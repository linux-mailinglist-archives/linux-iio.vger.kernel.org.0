Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9353372F21
	for <lists+linux-iio@lfdr.de>; Tue,  4 May 2021 19:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhEDRrl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 May 2021 13:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbhEDRrl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 May 2021 13:47:41 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5D5C061574;
        Tue,  4 May 2021 10:46:45 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id t4so4758101plc.6;
        Tue, 04 May 2021 10:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0/DN3S+KqczmNeTI/tnruDlhUcMg1qL74ctL3tIVK/U=;
        b=LraFaycts+W6qOEx9wmZ6qvgGMnNrS4WMRhOtMA3WBaVFimniBt1k+t3m/kmTnjflA
         onhAXEayfotCAmus7iWUmlc9ICmu3fk9wT+wOCdspwdAKeSsBj3hmVet5b5qAVG7us+l
         bqLjtp7sUKkX5boU2lwboct0sgfyjdEJI5i4zmxd4e36c3JD+V9SZ6tRfpt9b5PzrIQ7
         57ZwrBB0h1UARV3yLXFoAZPwneaHD4P0gXzbbG6iS7r32Nv93ZCMHVAbLk1gpHjwmT9T
         MXxSvKg516ybq2XXFONekAlHfhuM7YsE2q4mxl1awYfnibz9Gt9w/rqPx9Kq9PCiq0zP
         w2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0/DN3S+KqczmNeTI/tnruDlhUcMg1qL74ctL3tIVK/U=;
        b=CCIKGKVvykq8cLso9RMDkLbMsTbUD4hbkbnIJnvRa2sMpiX7BngtEH+/IVHrTzsggW
         VwIOAohHFRgwrYJqoP4OO4vFfGv3X+3mn+KPP4OH+Ia0aPxAUKtD25GxFJjS51QdYTTW
         iF6wumlC+8e4FOJcwQS/zYa8YyFlIdtOFq+ehELSllw8HCrWofCMSrG8Tb55ZoYzGmGR
         8MaorVD+efizj7oS9f32wvu/j1PvFZcmlkolvDOirxMXIPdIM3UIYNFUSyJZ28spyIYo
         0mmqmu73PNllzHlpJKRaKX9K0BrUxaBuxYxhrE6QTrqcAITN5N5fY28vhKkxP5hwrqto
         cmfQ==
X-Gm-Message-State: AOAM533WhPs4DcHbcu9YiEVLYumHd2neAcnVElgsTcUL4dpS5p6TFs0u
        /39F9nKFFj3IL4P7uNFPK3HcFpkRMddh7vu9Zeo=
X-Google-Smtp-Source: ABdhPJx2QAmmQRy6gtulUL1+mJeTTsAXKzF7dFGZo7GaiBTbfQaMhqCahuYtTv4bdD5KbNaaW3PJ26eXqFJrwXX4ne0=
X-Received: by 2002:a17:902:ecc6:b029:ee:af8f:899e with SMTP id
 a6-20020a170902ecc6b02900eeaf8f899emr21275580plh.21.1620150405093; Tue, 04
 May 2021 10:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210504174019.2134652-1-linux@roeck-us.net> <CAHp75Vd-iTkA5Y6tEHtfcqLxxmHaaU8nLQSL7eWb-gaa-c8AJg@mail.gmail.com>
In-Reply-To: <CAHp75Vd-iTkA5Y6tEHtfcqLxxmHaaU8nLQSL7eWb-gaa-c8AJg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 May 2021 20:46:29 +0300
Message-ID: <CAHp75VdOPkRrAWo9tFvN-9HhXfCGo8hA7V0jypPiLnibUCbuVw@mail.gmail.com>
Subject: Re: [PATCH] iio: bme680_i2c: Make bme680_acpi_match depend on CONFIG_ACPI
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 4, 2021 at 8:44 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, May 4, 2021 at 8:40 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > With CONFIG_ACPI=n and -Werror, 0-day reports:
> >
> > drivers/iio/chemical/bme680_i2c.c:46:36: error:
> >         'bme680_acpi_match' defined but not used
>
> > Given the other patch, question of course is if this ACPI ID
> > is real. A Google search suggests that this might not be the case.
> > Should we remove it as well ? STK8312 has the same problem.
>
> For this one definitely removal. Looking into the code it suggests a
> cargo cult taken that time by a few contributors to invent fake ACPI
> IDs while submitting new drivers.
> Feel free to add my tag or if you wish me I'll add it explicitly.

Had just looked at STK, the same guy as for AOS2315. So, also to remove.

-- 
With Best Regards,
Andy Shevchenko
