Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B7E445199
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 11:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhKDKjJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 06:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhKDKjI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Nov 2021 06:39:08 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C28C061714
        for <linux-iio@vger.kernel.org>; Thu,  4 Nov 2021 03:36:30 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id m14so19214447edd.0
        for <linux-iio@vger.kernel.org>; Thu, 04 Nov 2021 03:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pYTdmwqApW+ajXJX3GXb8H/o010P3CMggk5jYNslQf8=;
        b=fUTYnMoMhtQGvSl0DNU9td6FIIGn2PQuXnrPjgOxum2q0eCeOdAbsaAHx1LA1n404u
         wTNFEpMhVQWT5yY/Mgh+VpGshvxheWslQDq8xzoxmr+9lIQwXSxwQcbeJqnnbg/RuvbG
         bnsHhcAJCvlMVVyLHhTARTXKBVO4XDeSj8ZL9HscslODBw1sbJxCb8IRuf+bsqzYRuhx
         JuzbssaFZ9hshOC565W1j/yLsKlLn0fezhQ5CvvhG8l+66BNzkk4Z1tWqzVdWzvlBxMP
         Lz4PKFtp+FWWaJrXbsyQkqLQWh3SpPaapVWifa8nMrrWFnazrt8+Y1OVR2KAUnQ/bPHS
         qBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pYTdmwqApW+ajXJX3GXb8H/o010P3CMggk5jYNslQf8=;
        b=zoJcr7cIlPKlgvADLoeZdIY7dXjecPsVUnl3RKg5FzJiu4pywiamzZRgqJI/aKWedk
         7P9WiHu+hgEMra+wtibBYPrVfX+CI+7fcwpIYrwBCkT7he8DtyUFmdILo2QRXOjQb8aR
         BJa6+fp2rOMqx4Y3CQ77YwfFzqirZ3h0BcHH/bYcqQ55LqOHkuiNIIk56QwekcIHPU2v
         cHct1S0w/n+YNQsbVyuPmB7+MLykq22GFIhNyGV8JEvxAtuvqr7vCeNh6VyG/Ep3rTFP
         fSaKtDXoFfH7hYHf9FE82viSwlY1t+GKR5lbNm87Nyua5QJ/m+VEyqX7JGxIKvLvasyf
         xZ9A==
X-Gm-Message-State: AOAM531vXwlXdjQAlOVWzpdikjEAsaLHMGViab9l3SPTN8vCSUv3S9MQ
        Imuaqehgwdz9bjisF+n7RUMRpEOdXQVTWZIQs5M=
X-Google-Smtp-Source: ABdhPJx6j8VETVMSDKw5L6e43EYyV/4wEbHo7gujWDIjVv2oPT1roOeu3be6cG4RaCLPyjB16kae/wsmPDY6us2IlbM=
X-Received: by 2002:a17:907:7601:: with SMTP id jx1mr62211387ejc.69.1636022187864;
 Thu, 04 Nov 2021 03:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20211101133043.6974-1-lars@metafoo.de>
In-Reply-To: <20211101133043.6974-1-lars@metafoo.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 4 Nov 2021 12:35:39 +0200
Message-ID: <CAHp75VeZgi6CS6c67pHUARDLp_oR4ek9ctBiAy7=1KMC6q932w@mail.gmail.com>
Subject: Re: [PATCH] iio: dln2: Check return value of devm_iio_trigger_register()
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Jack Andersen <jackoalan@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 1, 2021 at 3:31 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> Registering a trigger can fail and the return value of
> devm_iio_trigger_register() must be checked. Otherwise undefined behavior
> can occur when the trigger is used.

...

> +       ret = devm_iio_trigger_register(dev, dln2->trig);

> +       if (ret) {
> +               dev_err(dev, "failed to register trigger: %d\n", ret);
> +               return ret;

It's fine to use dev_err_ptobe() in ->probe() even for known error codes.
Hence,

if (ret)
 return dev_err_probe(dev, ret, "failed to register trigger\n");

> +       }

Should it be a separate patch?

-- 
With Best Regards,
Andy Shevchenko
