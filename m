Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B847681AB1
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jan 2023 20:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbjA3Tlf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Jan 2023 14:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjA3Tlf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2023 14:41:35 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7CC45893
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 11:41:34 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id d30so20654341lfv.8
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 11:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5mw0wIhoPstMNc40mijloxvXEEALqiMl1EzY+MVPBe4=;
        b=Ck8ICKpHAuZhrKp22Gpt5J/EXv9DExRl5uoqHrnTUu8Vvj6UggiLJ8snNs3ZQSqsLk
         ykfDY23pEp4Q039eOF9Jdp8LUvfo7B4DGYxv8m0brqKlADvFn+MWM07558wcqsX+Iur0
         HobcRrcf4uJv+jbkKXL8LUqvmngzy1XGCK42g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mw0wIhoPstMNc40mijloxvXEEALqiMl1EzY+MVPBe4=;
        b=f205KbsC8fyTpZdCa7G9zYtIEoQT8/fhi3yhL+XcrkqBRI6ovEFCM4HKgUGJfFXR9J
         KHWHaMFK2NcVelZGFSAUMLOl4H7mD+NmhryQhlBRon3IaMY36CaZnjVmHnMe8rkBXWah
         IF+2H96dh6ofQkJX7cOBNDDE9U+q6zgBxnHYoU0Diir28DUkZrcbIXppvoN+dJHrNAXL
         DW/zH8B7JvKx6/nQ0i1knZBd0LPohxaTT/Atn4a4D+L1mCDuauTOL2aNAbRi/yE8o8xX
         B7fZccn+sdgH6ElZscw4MRqyW+EavfzhkUd4KVF1sYTOpZpQRyQf5VsWpdkHWZ0PG8Sa
         nrkw==
X-Gm-Message-State: AO0yUKXBdwhmKRnD9JmxZLG1BwodmfouRR9W1d3h+RABtRL6kyYf2t0/
        MSzuPTaPT0Vn5rYfz5vMa/gu+RLRA5b+uDXHnP6o7/vLnpw30g==
X-Google-Smtp-Source: AK7set+VuTLKVTk+mRqfU+AFnmWKGVjfYl3rY5slLWfs7xEWyBBz73NrNG/XTy5IkneP5n+nQ49NZN1qqw9vDMSn+Y0=
X-Received: by 2002:ac2:4c99:0:b0:4d8:7552:2c19 with SMTP id
 d25-20020ac24c99000000b004d875522c19mr296060lfl.34.1675107692607; Mon, 30 Jan
 2023 11:41:32 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 30 Jan 2023 11:41:31 -0800
MIME-Version: 1.0
In-Reply-To: <20230129003753.1980309-1-gwendal@chromium.org>
References: <20230129003753.1980309-1-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 30 Jan 2023 11:41:31 -0800
Message-ID: <CAE-0n510nBDOdWXH43qhRtVsQOCPCbkeP1wCr2LvGXbbXyg5yg@mail.gmail.com>
Subject: Re: [PATCH v3] iio: proximity: sx_common: Add old register mapping
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org
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

Quoting Gwendal Grignou (2023-01-28 16:37:53)
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
