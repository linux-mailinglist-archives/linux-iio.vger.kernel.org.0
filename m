Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B36F29A7F8
	for <lists+linux-iio@lfdr.de>; Tue, 27 Oct 2020 10:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409440AbgJ0Jf2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Oct 2020 05:35:28 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:38976 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409421AbgJ0Jf2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Oct 2020 05:35:28 -0400
Received: by mail-pg1-f179.google.com with SMTP id o7so453799pgv.6
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2020 02:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TczBmeup4ohP8AGbwR/KEnpgEbWlNFGFgfYmsBw52/s=;
        b=n2mLDwRytMgF1C3i+zXNbMqG1byHuPgQZsUFOWniuAwG45lhmlT45sl6+E677tNn28
         hsHDIwZ4BwLih/fyYgCxigWvgdlmlfkkyDfhlfEZMjTF2SF6iIXj/Kj5WTPfMGT1mYC3
         dUp20mbwR3npJrXCw0LCoIaGV2g9qyU++CD+gotlFVeLf2dr7AG1efWjfI2GDAvp/qkh
         amxJwOOPsc9v2sC9oCE7D5nq/6emoYSmWEDrxoqyxdpZuCni/1pqNH+PaNthI+Hd3EZd
         Xak1u0B4Sj0CYAXILXX76U/Ko4dnpCH8aJUH5NntgQ01eZA1W5fPbTVJiXKChurDy/7w
         cvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TczBmeup4ohP8AGbwR/KEnpgEbWlNFGFgfYmsBw52/s=;
        b=SMXl7YtXneSX1l3a64WIxZ427g0ROvx/AWi345ne0cwBI3LBPOY+5GDRBAZ59NVIri
         rdRpW00NvIBXpjg3l+eM8WhrcBe69xlMYVaroX/vTy1Mw9V5fYFy8k92uW7MdV1I+W9l
         mU5dmIDmf669A8Z1DBaw8aZm4VLTZ2rfJyeZvzF8yEzMuerLbTFbJQt77kzJuNVAAvV8
         DBFuHwe+4ZcLsOdN4FmTj6Z4Awn0E2JRn/ibcIrEptTMwqH6F0BDb+Cp9viVrHrj1uJG
         x76Yb1GZEOubbiS8dCCo7GVJCH4rkno0Atsw+2RoorIYJtqCiQlzuckZJwBz1noP2o3y
         zB0g==
X-Gm-Message-State: AOAM532GyPHFTbqFN1geVT0aPbO2vv7kqEDPioJ/wvSEOvBeRI9IPPau
        pgHyt3DURrqFBRu+F940OQTepCDkySefqcqcAowoIOOmWl0=
X-Google-Smtp-Source: ABdhPJwcGj3IgS20eq4RuAU77N7yuY5FLr0W5jHch/Qa3GguXqvv9W+glWFeKCdtC8jgAgWKghUUOUD1rOZrz9kr7Og=
X-Received: by 2002:a63:d54e:: with SMTP id v14mr1190300pgi.203.1603791327373;
 Tue, 27 Oct 2020 02:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAJyU85OXRWuVdFhTB7jdp=ggBDDmGTiQ-CahWbw_6cYrGUF5Ew@mail.gmail.com>
In-Reply-To: <CAJyU85OXRWuVdFhTB7jdp=ggBDDmGTiQ-CahWbw_6cYrGUF5Ew@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 27 Oct 2020 11:35:10 +0200
Message-ID: <CAHp75Vew1zt+oo9RXn7_XjZPCQEfqQLO3cANFipfoBbmKAqMWg@mail.gmail.com>
Subject: Re: Linux Missing IIO
To:     Matt Wyatt <matt@biomason.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 26, 2020 at 9:38 PM Matt Wyatt <matt@biomason.com> wrote:

Sorry, this must and actually has been removed w/o consideration.
If you wish to communicate, find a way to get rid of the below.

> *This message contains confidential information and is
> intended only for the individual named. If you are not the named addressee
> you should not disseminate, distribute or copy this e-mail. Please notify
> the sender immediately by e-mail if you have received this e-mail by
> mistake and delete this e-mail from your system. E-mail transmission cannot
> be guaranteed to be secure or error-free as information could be
> intercepted, corrupted, lost, destroyed, arrive late or incomplete, or
> contain viruses. The sender therefore does not accept liability for any
> errors or omissions in the contents of this message, which arise as a
> result of e-mail transmission. If verification is required please request a
> hard-copy version. bioMASON Inc., PO Box 110345, Durham, NC 27709,
> www.biomason.com <http://www.biomason.com/>*



-- 
With Best Regards,
Andy Shevchenko
