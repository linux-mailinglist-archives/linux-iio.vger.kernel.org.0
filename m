Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A2B414C76
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 16:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbhIVOxv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Sep 2021 10:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbhIVOxu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Sep 2021 10:53:50 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A115DC061574
        for <linux-iio@vger.kernel.org>; Wed, 22 Sep 2021 07:52:20 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id t10so12938669lfd.8
        for <linux-iio@vger.kernel.org>; Wed, 22 Sep 2021 07:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MXaT+d5bqa8rCsis/KSO/9vrH+ODW2z05Z53htSzAEs=;
        b=l/Hpb3E7wSo7tVIGxBP3QAeeCHhP6AeO3K8/eq57Gx1CHNGmtY23rnX05DTTsCGpos
         GX49LuO9CqqB/nzWYZOFU6GqeP8d3/IVFBjQ6bptu7TQOGBmGIt8x9LMk3yN4riqefCA
         NNlnk8flR2s47Dzp6pMNsNUIizu7oiFuM1QonMVSIzVBVCBvIRdpuZH6bvStqPFvqx8t
         nzPBy0fHu14mXkwkHpWW2UsLisu2xaBB8iosUSO+1EVx1At98UATgha+ciAk2gcKysgo
         SXw+fEBgt7VMsBNuoZuQQSy9aAPJvAssQiMVmAejP94JWKHnxjq1Ayv3iVHXkOJ6hdNK
         b2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXaT+d5bqa8rCsis/KSO/9vrH+ODW2z05Z53htSzAEs=;
        b=cHhuXqQRXwU0139NNQmacI0VOjrKURqViB0xwmxRMJOTrLoqiZymx5blLGEkJVNB8A
         9h6DQFSLuJyxUwdlryF83ZKDSijcTNLmDFpgf3kSuTJCKVuIdehYAogGwRrETJ32tyCy
         LzTeIfXkO/lFvAou5LealVgA9xwuAmRg0s0sleN2nLzarQtc6vKBuiUD55847TyRjV1i
         zChg3eACovGOmdwWbTlzoYYs5oeaNHYNhrPZFGT7/ttLI48Ov9RbWpUuLeKw7qpZDKTU
         fEfvrBHM9jC5GS+Po78M7hxqF4Vx9eeSaQ33zuiAZdCYnaWAaP3rfe21Mc75jm1+krUD
         ySEA==
X-Gm-Message-State: AOAM531ORmTwFmV9NmPOkVKV/Sll9l5nB5nulH2T/1iiwv9RGD8jMm7R
        EfXdTtQKG2Coy0W2BbG22wB4FCnnKz1mYIoEE3PKGaHTcTU=
X-Google-Smtp-Source: ABdhPJxKnrui5xMinmLjf78Kl4e0MlHhNhDdxwDroIXse/rVwK2BGuMxvFMF0wN3NC7q4FWCUM8zXPe01yNhpcU8zRQ=
X-Received: by 2002:ac2:4bc1:: with SMTP id o1mr9780lfq.113.1632322225221;
 Wed, 22 Sep 2021 07:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5Cwdn_-to8G+RvVUbG+UkYM7+budUsvWVLeY7PutoO2Mw@mail.gmail.com>
 <74f1974b-ac08-96f1-887e-99580a2bf212@axentia.se> <CAOMZO5Bhs3qLwgqGYHO7Oswr1qvarkzmNFyWQi3-_geZTj3BVA@mail.gmail.com>
 <CAOMZO5A0a20_+JHmCMYXLuZYCE04GDTqt0x_GXtVxA5Q4MSAog@mail.gmail.com>
 <73d0ede5-8a35-7e3e-e685-235f39ea28e7@axentia.se> <CAOMZO5Ds8hUc1=Jv6YHgNUnvGH0JWB1yX0sMccoUVcZ6tyyTKw@mail.gmail.com>
 <CAOMZO5DtNkfqFAhFtzA4x+W5eEes_pHNGouX35tNL+8hfpq02g@mail.gmail.com> <ee5d8cf0-591f-7296-28a8-d78159f5d6a2@axentia.se>
In-Reply-To: <ee5d8cf0-591f-7296-28a8-d78159f5d6a2@axentia.se>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 22 Sep 2021 11:50:14 -0300
Message-ID: <CAOMZO5AQk4zkgwk9ALkaasFv6t68K-bO6roki1tcdgnyk0wuTg@mail.gmail.com>
Subject: Re: Reading ADC that comes from a multiplexer
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Peter,

On Wed, Sep 22, 2021 at 11:28 AM Peter Rosin <peda@axentia.se> wrote:

> Nice!
>
> While I don't completely understand that iio-device node in the beaglebone
> dts that didn't work for you, it looks like it's just a renumbering thing?

The beaglebone dts uses some undocumented properties such as:
iio-channels and iio-channel-names.

> However, your version only remapped 4 channels, and in that case your new
> iio-device only had those, i.e. 0-3. But the iio-mux was looking for the
> missing channel 4. Maybe that was why that variant didn't work?

Yes, this is where I got confused.

The stmpe811 has 8 channels. On the apalis board, the first four channels
(0 to 3) are used for touchscreen. The other 4 channels are for general purpose.

The ADC that is connected to the MUX is channel 4 (which is the first
one that is
free for general usage), so I had to pass:

io-channels = <&adc0 0>;

in the mux, instead of  io-channels = <&adc0 4> that I was originally trying.

and now the mapping is correct and I can read proper voltages when I
switch the mux.

Thanks!
