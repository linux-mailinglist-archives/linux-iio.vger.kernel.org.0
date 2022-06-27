Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE90555C3B3
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 14:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbiF0N31 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jun 2022 09:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbiF0N3Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2022 09:29:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCCE6449;
        Mon, 27 Jun 2022 06:29:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FA9E6131C;
        Mon, 27 Jun 2022 13:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2776C341C7;
        Mon, 27 Jun 2022 13:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656336562;
        bh=koP0LmMICCW2tEjuoT240NQp9NWZVgkESEstwnzFVEU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pXnBwbGpnvLxDLqShZ45Xp/YVOroDAW49CNWQdsxNPxIhyY27pZATkEz9mZJTB9Qi
         29xtzFsNQn9Lj21GILf/oW1JPd2t1mZBVxjmjr4Za84dXQ7Yu8aULEj1li0qYweuBY
         Dk2jO43GpFnPDGTy3y9GycgUgtpOWHNQgwz6EZN1ZLt+mSvm8y50AB1IUUsJy9QcyQ
         TiYLhHVrz3jDF6RUURmqC1VxbHtiOHkAVICXJ32T9VcMR1IRhZMKDGyx+6Y+MwRL3N
         nUY8phHh+fKjjcIeiBTomavLUlzV4Lk4yvenffVzdWCq7Bdkfe2TMIdQZxvegpIdJw
         ec88Sfv4dpIFQ==
Received: by mail-ua1-f42.google.com with SMTP id k19so3443852uap.7;
        Mon, 27 Jun 2022 06:29:22 -0700 (PDT)
X-Gm-Message-State: AJIora9QWuOcJx/oBfjIaE+rsqwhcDBoNaK+6jCG5kT6VFEx4R+g32Iz
        QUwDG6hJpbn3sIKiJ9QPJavPu3i5nm+q+OpfLw==
X-Google-Smtp-Source: AGRyM1tOtcxuT6/x81UVoJBJzNeJo6UBAxDP1STaallBGDtYQjq4Xv5cpryqMvdjHDlsdwgzmLcQQu/RDxSCO35hOeU=
X-Received: by 2002:a05:6130:3aa:b0:37f:26c0:e196 with SMTP id
 az42-20020a05613003aa00b0037f26c0e196mr4580118uab.43.1656336561682; Mon, 27
 Jun 2022 06:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220614151722.2194936-1-sravanhome@gmail.com>
 <20220614151722.2194936-2-sravanhome@gmail.com> <YqpkXYAtXtvzX44J@google.com>
In-Reply-To: <YqpkXYAtXtvzX44J@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 27 Jun 2022 07:29:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKg2rv5_ZKqRpNcxQVDqvETOrKXfvWMDvemDRgS57yFqQ@mail.gmail.com>
Message-ID: <CAL_JsqKg2rv5_ZKqRpNcxQVDqvETOrKXfvWMDvemDRgS57yFqQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: mfd: Add mp2733 compatible
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Saravanan Sekar <sravanhome@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jun 15, 2022 at 4:59 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 14 Jun 2022, Saravanan Sekar wrote:
>
> > Add new compatible for mp2733 mfd driver.
> >
> > Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/mps,mp2629.yaml | 1 +
> >  1 file changed, 1 insertion(+)
>
> Applied, thanks.

This breaks linux-next. Please apply v3 instead.

Rob
