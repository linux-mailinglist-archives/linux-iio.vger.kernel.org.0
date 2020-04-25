Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83DF1B87F4
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 19:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgDYREW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 13:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726146AbgDYREW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Apr 2020 13:04:22 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3498BC09B04D
        for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2020 10:04:22 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t40so5224927pjb.3
        for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2020 10:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNflyFnV/TC3B3/b75yNBanubXUp9ZouaK20FVEG1Bk=;
        b=lbuxksf03IPd8AtfZ7bBEGvc5bjewR7ftzAQGvcv8UXcDWbKcyndCXdrixpsQCDkLO
         hVYXYFPeSpE6nMFIYutHvQcC2PToBxDz4wGV20gc4l7biE+G4T/gAMcRBlfN6mTFfN59
         T1gs1YPNw9BN2fW1DAfp6H4ViSbuSuaFs2KFq/ZKo5bvinfPnqHcBVLTmlflm8g2b8oQ
         v8PGjvgf4qrmJEgK6ZCG8T7UaSOLYtZkGhqVaX2WdelKm1/H1gtTKivI3qUy3A1K1dyJ
         jZ2FADq2ezJqoNFALZxcl1ctZkrjoeRX7kbQy+03aNt9opHsY0jzuWWJ+jO4rjFQ4w7k
         RjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNflyFnV/TC3B3/b75yNBanubXUp9ZouaK20FVEG1Bk=;
        b=IKck4Qe0AJh7A+D7vA6R0FxY0bdFP7nO5h4+PnmIQ9eLCval2KBmJUxnGkow4wUiYv
         CNCszBEiGaQPTqjSU4utpllgeP0PgvkjYEks8UD/gMZQC1sPI+rgTe9kIe0OUR03zevh
         VBe40/L78FuUAyXAVcJgpV/0COjN/VaXO1PSe+T1f7AVjqGJS7f61Lp/SnknGSaexN7S
         gVfTdXHNGqGBgf9VUUSvTr9awBmTF+GHHHS6FoXL8YJdP0qBUvC7rGZCzd6z1rKix1dM
         bqCnt92PygwbBLwTd5z2J6VkYobx8z70SnpdJL1xpocn9iANAWVTaYw6jN2CujixoTiF
         NFng==
X-Gm-Message-State: AGi0Pua3Qm/WiTOnyUqWNaNfn1Ovh/slNiQF9c+Fbz3of0/2XPqBEx2c
        T/UjMA02eSZedvNL47AIpeUBY0icogyZVtLRArfXctu30YA=
X-Google-Smtp-Source: APiQypI6VzfYYmOhXo15GAy3OloBHN08BsDD3qCIJLDFDTN57Zue908ZombZIqfgNKQN+hkzTcnrZdayYq7Fcw/Pzsc=
X-Received: by 2002:a17:902:aa09:: with SMTP id be9mr15484542plb.18.1587834261791;
 Sat, 25 Apr 2020 10:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
 <20200421003135.23060-16-andriy.shevchenko@linux.intel.com> <20200425175345.693b2f36@archlinux>
In-Reply-To: <20200425175345.693b2f36@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Apr 2020 20:04:09 +0300
Message-ID: <CAHp75VchNqVs34g8ox8qkN-dBj9qK8Z1x-zRCuACWundZq2oKA@mail.gmail.com>
Subject: Re: [PATCH v1 16/16] iio: st_sensors: Use get_unaligned_be24() and sign_extend32()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Apr 25, 2020 at 7:54 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 21 Apr 2020 03:31:35 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > Use these functions instead of open-coding them.
> >
> > Cc: Denis Ciocca <denis.ciocca@st.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> This one already has the header, so applied to the togreg branch of iio.git
> and pushed out as testing with no changes :)

Thanks, I'm sorry I didn't compile all of them and by some reason
thought they all have it already.
Strange we didn't get kbuild bot complains...

-- 
With Best Regards,
Andy Shevchenko
