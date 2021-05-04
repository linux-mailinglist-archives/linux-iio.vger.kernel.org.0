Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6316D372D09
	for <lists+linux-iio@lfdr.de>; Tue,  4 May 2021 17:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhEDPfW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 May 2021 11:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhEDPfV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 May 2021 11:35:21 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF408C061574;
        Tue,  4 May 2021 08:34:25 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso1260473ote.1;
        Tue, 04 May 2021 08:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4jLpWtZCHYr5J+Yz2qAb7LAorGFHZkc9BwK/PNvj/98=;
        b=WjvNMIXP3m1ryVSy7NgFFGUY2gIHL/sXp7cA5GgFYTkOmMU9VbS47Y1FW11IWnS9Lw
         gKEdSRWsvbsaQFPe6fv6WQdQZhjIqPx6kquW7O9gJfoSFJqgzo+cNmwKnJFLJq9lhm0z
         n9XlfCROnh1/A0YVS0iwJMdN1qvzipJDc2tHTBc18MbiqeUD+/wXUOyN/hooCmCAy2Sg
         5SjPlVlIOmPRm7wEOhkYiQkuQf3YUyctuxx2JiHKQa1JC8iO00SmdphbTY7kT725YNjb
         bnAgisSEBKpxMziw1PO5mq9TUcDJJKCBNMWZbCd6OZeQwzeZR6ZYlxfHCW+gkB3PNuJ/
         f/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=4jLpWtZCHYr5J+Yz2qAb7LAorGFHZkc9BwK/PNvj/98=;
        b=pY5rAIjtLa2Lho7VbWunwaWbKwGZwvhSsbVvdARSydZsJcLvFOVDQNToP7RfTibFvd
         lr0mSc1J+mrGWOaLTHkuh/g2NqmbZUqoEueibuiiJ1aPCNAHvc/nfECQnvAcZ5JeMsvk
         tO4cG1DKER2qiAtcMTdNk/mL4Nr+iiUkHayBarSOE6nfo7mDeNVAR58kzHsdwuMnCFZ6
         JoeJJ194GBY3tuCsTa6TczhloSKw/E65JoWYyhh2SjEzZyukslVcF8PU7Fzzwxxf+C6y
         hejeMmvuC5sfhcf01vRFWyecdogjU70pLGYbyx2/GzXzcORBhNYdUw6fCWp4PPYCf+Uf
         uDhw==
X-Gm-Message-State: AOAM532sUp4xf68lRE5flnkjkzBYlPZV+ISd133Ljm0misOhAOXLKzaA
        mEgSRoEH31A/xYvu1cT1lT8=
X-Google-Smtp-Source: ABdhPJzRmuHlbWh7GkvstASQoMXpyAcEMBt/5kCELlWiJ9lyjIxM7rd0ynAZaW8/P2fsNZlxP3egOg==
X-Received: by 2002:a05:6830:34a1:: with SMTP id c33mr7064795otu.217.1620142465151;
        Tue, 04 May 2021 08:34:25 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c7sm714754oot.42.2021.05.04.08.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 08:34:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 4 May 2021 08:34:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: am2315: Make am2315_acpi_id depend on CONFIG_ACPI
Message-ID: <20210504153422.GA2117112@roeck-us.net>
References: <20210504143019.2085111-1-linux@roeck-us.net>
 <CAHp75Vc99LzOpe1EeTwoM+wkwyZkTamj6-=MSe_MBZ1+XUcebg@mail.gmail.com>
 <CAHp75VeLyxbwbDtCca5goCEWn7vbQ9d_Fb01dWj1CP8eBb9jJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeLyxbwbDtCca5goCEWn7vbQ9d_Fb01dWj1CP8eBb9jJA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On Tue, May 04, 2021 at 06:15:44PM +0300, Andy Shevchenko wrote:
> On Tue, May 4, 2021 at 6:11 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Tue, May 4, 2021 at 5:41 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > With CONFIG_ACPI=n and -Werror, 0-day reports:
> > >
> > > drivers/iio/humidity/am2315.c:259:36: error:
> > >         'am2315_acpi_id' defined but not used
> >
> > ...
> >
> > > +#ifdef CONFIG_ACPI
> > >  static const struct acpi_device_id am2315_acpi_id[] = {
> > >         {"AOS2315", 0},
> >
> > This is a fake ID according to the specification. Do we have any proof
> > that it's being used in the wild?
> > If no, I prefer to drop this ID section entirely.
> >
> > If yes, needs a comment which device is using it (however it may be
> > out of the scope of this fix).
> 
> Googling shows zarro results.
> 
> (Yes, I know about meta-acpi project and I may fix it there, but it
> may not be considered as a "being in the wild")
> 
> So, please, remove the entire section.
> 
I'll send v2.

> Feel free to add any tag from me (Rb, Ack)
> 
Since the change is substantial, I don't feel comfortable doing that.
I'll copy you on v2 and let you add the tags yourself.

Thanks,
Guenter

> > >         {}
> > >  };
> > > -
> > >  MODULE_DEVICE_TABLE(acpi, am2315_acpi_id);
> > > +#endif
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
