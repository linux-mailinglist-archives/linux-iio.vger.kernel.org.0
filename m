Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F567D1F20
	for <lists+linux-iio@lfdr.de>; Sat, 21 Oct 2023 21:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjJUTe4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Oct 2023 15:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUTeu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Oct 2023 15:34:50 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27627197;
        Sat, 21 Oct 2023 12:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1697916852; bh=z/PQtjKHGnFlr9gaVSJrAXB/j6VUiwPJtpZZinALBa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=EZiTc8+EP4ALVVxqbCe/MQaaQ5wV6r5LnwqVpuKb66Y8qK3pzQPHI0ItxbVvvnzpl
         v6Q0v1KYrUuSLthCBZ7PXs3mzLvWFclDa8uP8sXWkAUt142YU80NtbN98Nm1B3gFp5
         jcP1xikBDIj+u1AuW6tIuevrRyZMr7OTHPyeitjQ=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     Nia Espera <nespera@igalia.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        Rob <Me@orbit.sh>, Clayton Craft <clayton@igalia.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: sm8350: Fix remoteproc interrupt type
Date:   Sat, 21 Oct 2023 21:34:10 +0200
Message-ID: <6985565.DvuYhMxLoT@z3ntu.xyz>
In-Reply-To: <ca42af11-7b92-4d07-9b93-367f92c886fe@linaro.org>
References: <20231018-nia-sm8350-for-upstream-v2-0-7b243126cb77@igalia.com>
 <20231019040623.GA5142@thinkpad>
 <ca42af11-7b92-4d07-9b93-367f92c886fe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Samstag, 21. Oktober 2023 19:44:20 CEST Konrad Dybcio wrote:
> On 10/19/23 06:06, Manivannan Sadhasivam wrote:
> > On Wed, Oct 18, 2023 at 10:17:15PM +0200, Konrad Dybcio wrote:
> >> On 10/18/23 16:25, Nia Espera wrote:
> >>> In a similar vein to
> >>> https://lore.kernel.org/lkml/20220530080842.37024-3-manivannan.sadhasiva
> >>> m@linaro.org/, the remote processors on sm8350 fail to initialize with
> >>> the 'correct' (i.e., specified in downstream) IRQ type. Change this to
> >>> EDGE_RISING.
> >>> 
> >>> Signed-off-by: Nia Espera <nespera@igalia.com>
> >>> ---
> >> 
> >> Hm, apparently 8250 and 7180 have the same thing.
> >> 
> >> Mani, could you elaborate on this?
> > 
> > So the remoteproc driver expects the wdog interrupts to be edge triggered
> > as the rest of the interrupts, but DT specifies them as level triggered.
> > This won't cause any issue during the first instance of the probe as the
> > driver requested trigger will be given precedence. But if the probe
> > defers for some reason and during the next try, request_irq() will fail
> > with error similar to below:
> > 
> > irq: type mismatch, failed to map hwirq-x for interrupt-controller@xxxxxx!
> > 
> > This error is often confusing and I tried to fix it. But Maz didn't agree
> > with me, so I just ended up fixing the DTs for some platform I have
> > access to.
> > 
> > So ideally, DTs of all platforms should be fixed to pass correct trigger
> > type.
> So, this should be edge for all platforms, correct?

I'd believe so, iirc when I looked at the driver it always requests that
interrupt type.

For reference, these are my patches:

sm6350:
https://github.com/z3ntu/linux/commit/0522b7a1b981d80884a785c7e654bb5094ea1bc2

sc7280:
https://github.com/z3ntu/linux/commit/ead1d7b8f5648535b857cfa9250aac2480f00ed3

> 
> Konrad




