Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8BA1F0A23
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jun 2020 07:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgFGFZV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Jun 2020 01:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgFGFZU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jun 2020 01:25:20 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2F8C08C5C2;
        Sat,  6 Jun 2020 22:25:20 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id i25so335314iog.0;
        Sat, 06 Jun 2020 22:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6PqJb17I6QgT7Nro4ycEL6hayP8ZueptOHGiSgSXHWE=;
        b=sV9kx3X9IXfSemmDbjwavPRIqP8Nb9hBGJMfW1ALXD/KWrlUhQFhf4AJuSYmBmIeRY
         MiWfQ2wqU5QT/7+46Bhj3AMEL49KljqMAKYqFLvnxsVt57C6UfEm264hBCO+dD2eEh5f
         bVaTNWZgv1XufYIxemZHpzbzD5dfeZYYOd+eSZzeZJv8MDZSwbc+CDFUQHqTOsOyyGZQ
         bCoVYAHPCsDDXrlVN0NcK1rnZgKBxFHOILGgQS9j16oVzh0haQlb3xGAAIH3ZcjJsE5p
         PsoavWibCtnduHruLjj5PIUVwuJuUjrDZLOf01MtXtSAwXf0Bwf0FdtiBHK8f5HUUHrS
         ze3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6PqJb17I6QgT7Nro4ycEL6hayP8ZueptOHGiSgSXHWE=;
        b=OKEc0qYtYksumIfl2W9y9cdvws/FU1ghkulZJjLzg5ZAa0qPlv1ZxkTalGsrWGeeO/
         RFeKOwkPX3aKLfRSEfwvD6/GCZUtd/o9ZajYj2jeZn7MNtPhSTKPhml/8pZEB6ASpnIU
         vl/2akgc6XK9aHR5PEDZ7MnEeXsbSVt+lpUgkJArOaqs+6BBr6r53UoAiLrS+TCAhKz2
         6D4LyIb36HViSLCGWDCpK66hoeGuQ3tLujfoh0n112r6P+X9IWBlFvwrgZEpyKlhVf2k
         FWFBhvx5fLQgES8pJLKDiP+Cd6fVmIhysGZw406fBdvdmx+Hz9h+CtFiGua5kwswI78W
         GXMA==
X-Gm-Message-State: AOAM531IZWQdOKNJBVUFZkkK3UbZkVCgH8aBEPDuJOW0Nh/Hh6HqWf42
        U0byYjv1lHp3nH9b3VkfLS2nGi2bT7BIzMvPIKU=
X-Google-Smtp-Source: ABdhPJyTwPL32sde4zh8WMbaix8utZk0tcOKZ5NfrBXnrrLfp31fwdqGP1YUfkSeiw8B41SYBRi0T+ZG+tgw6yWqNb0=
X-Received: by 2002:a6b:c992:: with SMTP id z140mr16081932iof.54.1591507520092;
 Sat, 06 Jun 2020 22:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200316125046.GA447@syed.domain.name> <20200318021853.GC45571@icarus>
In-Reply-To: <20200318021853.GC45571@icarus>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Sun, 7 Jun 2020 10:55:08 +0530
Message-ID: <CACG_h5qvKvs1VdEYBwrcStfoqM16AvGVDhWp_AOeC3Xc3-dL-w@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] counter: 104-quad-8: Add lock guards - filter
 clock prescaler
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 18, 2020 at 7:48 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
> On Mon, Mar 16, 2020 at 06:20:46PM +0530, Syed Nayyar Waris wrote:
> > Add lock protection from race conditions to the 104-quad-8 counter
> > driver for filter clock prescaler code changes. Mutex calls used for
> > protection.
> >
> > Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> > ---
> > Changes in v5:
> >  - Change spin lock calls to mutex lock calls.
> >  - Modify the title description.
>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Adding the 'Fixes' tag:

Fixes: 9b74dddf79be ("counter: 104-quad-8: Support Filter Clock Prescaler")

Regards
Syed Nayyar Waris
