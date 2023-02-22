Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B11669FD3F
	for <lists+linux-iio@lfdr.de>; Wed, 22 Feb 2023 21:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBVU4s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Feb 2023 15:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjBVU4r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Feb 2023 15:56:47 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22253E0B2
        for <linux-iio@vger.kernel.org>; Wed, 22 Feb 2023 12:56:44 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id f16so9147374ljq.10
        for <linux-iio@vger.kernel.org>; Wed, 22 Feb 2023 12:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c3ml7RHO0nki+CdSWt9xcf+yF6MU1hgirFtbEyXAlGU=;
        b=dDmLWB4Hx2wQQbITSJ/nnnTbBgmeoJGRMLo+QPAo8ADtj0xAXTNV5ZA+DECXMkCR1a
         QOeyfwv0EJj3bEdbHx3KcpHYbhjKf2+A9C8ON0IL9L8qGtNvWjqhNzIXLnE90ltlRtvz
         q+9el1t36iXUBDIImBsptr82uia5HraHqSeyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3ml7RHO0nki+CdSWt9xcf+yF6MU1hgirFtbEyXAlGU=;
        b=Xw9ggO5/d4lm+celyyVZPRwHqW00fqiZ9VYvfsGa8WK1PXY2vr0koy52dB1NoGo5gI
         GyKLW6GJoJikAVXPrjAdG+1v8baQmEva8qw9vbpb3OPRgKp5vSV+ViW6Vt3FhQGvqT1s
         NCtZpl4hWjWMW2PEXfG4QFX3wOS/mi2pLRxwAflVsArweDcnmbKLAiZM+V1/I0LTDbAU
         lTfU+mVyNQa83S5to7FTeRaAOvGdvHRGbCVXcUMUdJHWBYYx9m6RXpAHrcWFPjm5nn46
         oCPA1OIfXXcUBLy57WV9uy1qgEvGjCPUTQw8plzf6ZGyadn6jVE/FuM4oPUhUgIO4ath
         Wjrw==
X-Gm-Message-State: AO0yUKUV3vVSYFNHxuqEYJXz54JJusnWDzJo/MUgNh6vKUTEFtKb3QN+
        bonjIE9y0aMy+3LHvb/VlRf2ZuDf2/QvETOvty5IHg==
X-Google-Smtp-Source: AK7set9dkEjA6Ruo1ht4hIu6ihGxBO3BC35+w6tSYCrwyHmJ4SxvG1dUEQt68wEr9UXD+Z+4471NNhqC5GubaGO6lmw=
X-Received: by 2002:a05:651c:895:b0:295:9626:a1d9 with SMTP id
 d21-20020a05651c089500b002959626a1d9mr1853166ljq.1.1677099402835; Wed, 22 Feb
 2023 12:56:42 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Feb 2023 15:56:42 -0500
MIME-Version: 1.0
In-Reply-To: <20230211002421.3447060-1-gwendal@chromium.org>
References: <20230211002421.3447060-1-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 22 Feb 2023 15:56:42 -0500
Message-ID: <CAE-0n52mN83_vE4hbk-cE+T_11--QHV5FA-Srd08PqfQrhRtHg@mail.gmail.com>
Subject: Re: [PATCH v4] iio: proximity: sx_common: Add old register mapping
To:     Gwendal Grignou <gwendal@chromium.org>, dianders@chromium.org,
        jic23@kernel.org
Cc:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2023-02-10 16:24:21)
> Older firmwares still send sensor configuration using a list of
> registers with opaque values defined during sensor tuning.
> sx9234 and sx9360 sensor on ACPI based devices are concerned.
> More schema to configure the sensors will be needed to support devices
> designed for windows, like Samsung Galaxy Book2.
>
> Support schema is: "<_HID>.<register_name>". For instance
> "STH9324,reg_adv_ctrl2" in:
>
>     Scope (\_SB.PCI0.I2C2)
>     {
>         Device (SX28)
>         {
>             Name (_HID, "STH9324")  // _HID: Hardware ID
> ...
>             Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
>             {
>                 ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /*
> Device Properties for _DSD */,
>                 Package (0x3F)
>                 {
> ...
>                     Package (0x02)
>                     {
>                         "STH9324,reg_adv_ctrl2",
>                         Zero
>                     },`
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
