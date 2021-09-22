Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC92414BB4
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 16:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhIVOXa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Sep 2021 10:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhIVOXa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Sep 2021 10:23:30 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B6EC061756
        for <linux-iio@vger.kernel.org>; Wed, 22 Sep 2021 07:22:00 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id u8so12255344lff.9
        for <linux-iio@vger.kernel.org>; Wed, 22 Sep 2021 07:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DeImWiO5hYjoJlkB/kGGuCDtTCip2+LdoIcZAT7i07Q=;
        b=FnT0AEerpXACeC/vBFW1+4Gnznpqoh0M0Ref7Rg+5gFFCWW44lMKb45+lcvffYZSmG
         s7Mkh1HclN1T3TXHNT+voRnA/wEooNdFqFxdi+DLoVku2PESrzUxyEBQFvIXavOUg6+4
         cNxubA/mZuOqxmtYHWA4B1KiiEv6lrFAjj/n7jn3IBT+8ceaCkabkTe6A07R9TVIVM7q
         tvc6NyKUIZETn3sqKKkL2fGthUKgbsP6NNwU0+XyzV06N7abcBWG+eUlXw1Rpme2RpGx
         tlvIhsskBlqULD1AcwjqjFfelJDU/IiRWHcJIxq++Rr4DqdpzhL2XjA3RLLVSjzDjzh/
         IQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DeImWiO5hYjoJlkB/kGGuCDtTCip2+LdoIcZAT7i07Q=;
        b=gBf4woZD9ruW9p2nJb9SzRHTbWCAUuQ6Slc0rT+s8nG6fFI5vwAHYRa4F4dMzoKGkR
         eD4jggXWvQ1RvUEcDqxDPf/3K0T/5vZYg0LgwtSMP0cJQmNweh0zRJdB67cWeBNQTrOx
         lj2ycyZM8+I3S7pguVSdvZbLSLqRSxSOMuq7A1gH9mayVBNeIKtYa5mHWKNlVzgB5NhQ
         dMR99z7CM5iQgyy6Uq8GFnZjNXUwEtwyYyc1M2yiW8211WUt9dPaqwVEzk6YBD59PTsx
         4SeDij9V08gYO9c12FMCygK1PPN9UwZxygENPWD+sWPppyGhCJlHfBdRDVudTnB2rnzY
         oC6Q==
X-Gm-Message-State: AOAM532UFMt43RdEI8gwCYUBu/Z/Dso8ByGgZPI3apo9aUYHIvUGb524
        nbO9wiDJBD9BEEP2SbpHDUAHQ6B0yXH9jKhOD/gbbNTexfA=
X-Google-Smtp-Source: ABdhPJz45LqivaZMJD/0UEikyylOsY3PR0Dck8r9DOMlcGtyk8hyNf19HVm+xGFC6LKykRF4ecsgmA4YoENTYkyCCZA=
X-Received: by 2002:ac2:514e:: with SMTP id q14mr28369543lfd.154.1632320420759;
 Wed, 22 Sep 2021 07:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5Cwdn_-to8G+RvVUbG+UkYM7+budUsvWVLeY7PutoO2Mw@mail.gmail.com>
 <74f1974b-ac08-96f1-887e-99580a2bf212@axentia.se> <CAOMZO5Bhs3qLwgqGYHO7Oswr1qvarkzmNFyWQi3-_geZTj3BVA@mail.gmail.com>
 <CAOMZO5A0a20_+JHmCMYXLuZYCE04GDTqt0x_GXtVxA5Q4MSAog@mail.gmail.com>
 <73d0ede5-8a35-7e3e-e685-235f39ea28e7@axentia.se> <CAOMZO5Ds8hUc1=Jv6YHgNUnvGH0JWB1yX0sMccoUVcZ6tyyTKw@mail.gmail.com>
In-Reply-To: <CAOMZO5Ds8hUc1=Jv6YHgNUnvGH0JWB1yX0sMccoUVcZ6tyyTKw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 22 Sep 2021 11:20:09 -0300
Message-ID: <CAOMZO5DtNkfqFAhFtzA4x+W5eEes_pHNGouX35tNL+8hfpq02g@mail.gmail.com>
Subject: Re: Reading ADC that comes from a multiplexer
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Peter,

On Wed, Sep 22, 2021 at 10:41 AM Fabio Estevam <festevam@gmail.com> wrote:

> but still the parent channel cannot be found.
>
> So I don't have the DT properly describing the ADC to the mux relationship yet.

It works fine now :-)

The trick was to change it like this:

-               stmpe_adc {
+               adc0: stmpe_adc {
                        compatible = "st,stmpe-adc";
                        /* forbid to use ADC channels 3-0 (touch) */
                        st,norequest-mask = <0x0F>;
+                       #io-channel-cells = <1>;
                };
        };

Thanks a lot!
