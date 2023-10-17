Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A4F7CCA5C
	for <lists+linux-iio@lfdr.de>; Tue, 17 Oct 2023 20:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344034AbjJQSI6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Oct 2023 14:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjJQSI5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Oct 2023 14:08:57 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5009E;
        Tue, 17 Oct 2023 11:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=APjuyiWE2A1xCv0iJFLThRZtUP3HKRJzts9gtiQM9DY=; b=gbF7Im3OHrj/dH7T6u2JsAS545
        GxzmYPwzdIdUmiVjZh7FjJXwlSLmngMkmZzfUWN6qyxpvKmh2OucQ8KrV2gP0YhcStjx3wQtTzuD+
        tJXGZXmEkK5wa2kD9IvVhmAjynHzaQZvoqKK4fyWn96M2HzMU00MTMZq2Bc79vMHwWrccuUAkVb8z
        HjoK2+M8aFKjg1trPxL9/p9RCMf2Kkkhuu8oMgUmv3Jk/GJ87KrMdipFnOT6uuh6W1M1nMkVkBxVG
        H2jCSonuRnmm2lVXqG0AHoIvhZQR7pugpeZG/ChA5SKKz5sUArwFDDJBynN7+zwSOGtIZNDCO27WA
        ZmI1mCYA==;
Received: from i73190.upc-i.chello.nl ([62.195.73.190] helo=[192.168.68.109])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qsoUd-001X7W-MN; Tue, 17 Oct 2023 20:08:35 +0200
Message-ID: <d41ee807-c21f-450e-b095-a7a22fe1d525@igalia.com>
Date:   Tue, 17 Oct 2023 20:08:31 +0200
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH 2/5] arm64: dts: qcom: sm8350: Fix DMA0 address
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        Rob <Me@orbit.sh>, Clayton Craft <clayton@igalia.com>,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20231016-nia-sm8350-for-upstream-v1-0-bb557a0af2e9@igalia.com>
 <20231016-nia-sm8350-for-upstream-v1-2-bb557a0af2e9@igalia.com>
 <69987d14-37d1-491e-99fa-9d0201112b67@linaro.org>
From:   Nia Espera <nespera@igalia.com>
Autocrypt: addr=nespera@igalia.com; keydata=
 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
 T+I7o407lOB8a/PJA2YXM4VVC/iyMBM=
In-Reply-To: <69987d14-37d1-491e-99fa-9d0201112b67@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 10/17/23 17:44, Konrad Dybcio wrote:
> 
> 
> On 10/16/23 14:47, Nia Espera wrote:
>> DMA0 node downstream is specified at 0x900000, so fix the typo. Without
>> this, enabling any i2c node using DMA0 causes a hang.
>>
>> Signed-off-by: Nia Espera <nespera@igalia.com>
>> ---
> Oh hmm.. I wonder if that's why I could never get one of the i2c hosts 
> on 8350 to behave..

Unfortunately, it doesn't fix quite everything. It takes the device from 
instantly breaking to booting and then spitting an error, though, so 
that's nice at least - and even then only sometimes. Probably missing 
clocks, but I've had it properly initialize once or twice at least.

> 
> Fixes: bc08fbf49bc8 ("arm64: dts: qcom: sm8350: Define GPI DMA engines")
> Fixes: 41d6bca799b3 ("arm64: dts: qcom: sm8350: correct DMA controller 
> unit address")
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Konrad


