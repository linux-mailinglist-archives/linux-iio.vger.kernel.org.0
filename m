Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A9C2E1968
	for <lists+linux-iio@lfdr.de>; Wed, 23 Dec 2020 08:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgLWHcB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Dec 2020 02:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbgLWHcA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Dec 2020 02:32:00 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E76FC061793;
        Tue, 22 Dec 2020 23:31:20 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id 2so14226451ilg.9;
        Tue, 22 Dec 2020 23:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4gPIAEkXtv9barModnSUNc5SUdtp7ZQjtRektNld8XA=;
        b=AvVUnWC0hx4f2zy46/gLhLZVzupkWmQDFH72rpoGNHTBq96eTytYGaK63pz1oB0FEK
         oqFVeW9e0yyEELXhZXwr54h8zVJU24pdbRTukgx0PUS4fkt4U1yUB0oA9RL5qiv2kLfK
         DmTuWFqUFvT1y9oWGMtZO3ofkY10e/iTwXEPYlpQ1lwkbHikU+NSUSM2lrodf9UrCsvG
         YFCX0HwvLRQ/pVQlIESXBgKKtjB8tED+xD2S6hRt648xnPOU1TaXH4GN1IJa2PfOc1Pt
         HiLW+mwytmhasWVIzPYhFX2n/t+x1thuugG2TfWOtt0Kh5XcLKFwL/Fs5xeP+bJJcsfv
         0o6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4gPIAEkXtv9barModnSUNc5SUdtp7ZQjtRektNld8XA=;
        b=BkPTc0HKzOrbDj1UTN+6ljM3RSnZzK0xSynC81EtdOUKtithHfc0iGwIaDZEIJZs6g
         bxZhOK4UJrymJMD/IPhCkjeD5iKtfmYnZEcU2epuzfrQCenRfrRFb7IQGXVSC49QVRN2
         f8ZnGZm3K7tGw5GfmshI+TSG/U42qHcDVrgscjb1j62xBVsRzW6ptFPvkOmnrO/0tXHn
         p0Jw6e6nOy6LzNfjJmQD5ejYVf5DIQKlZpt/SOf1w+F45+dz5+rAoWHsMCmS+LeuLZ9N
         roecT5ig6L7D3DzRFLsVYtCuIo8CUp8d5G8suyv/q+Ci4EA3p19oOdyY8mkR+3qmzbSO
         JnGg==
X-Gm-Message-State: AOAM532nlVZ2go1Uk5AtWvI0TFKjywqwZ4DPux6lDvXbUnH2ipc8H2Hs
        EdvllCoIPnONzZhOJrr3Y1DGgcsVkxHdh7rX71w=
X-Google-Smtp-Source: ABdhPJwbGmHdj2wSgAZPAb11LkRmI2i/vzUa0zI5NTpnaf3ctFttmhxPFEoELVaHEZWLkDJFGfeHEkYjFCPsk1s9KZc=
X-Received: by 2002:a05:6e02:96f:: with SMTP id q15mr24033717ilt.292.1608708679860;
 Tue, 22 Dec 2020 23:31:19 -0800 (PST)
MIME-Version: 1.0
References: <20201222131312.64957-1-alexandru.ardelean@analog.com> <CAHp75Ve06gYFE+U_XNZfTFceMEzmADR6wd0OYr+tVMQ6hW3MLQ@mail.gmail.com>
In-Reply-To: <CAHp75Ve06gYFE+U_XNZfTFceMEzmADR6wd0OYr+tVMQ6hW3MLQ@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 23 Dec 2020 09:31:08 +0200
Message-ID: <CA+U=Dsp-eZXgmp-+EJ8Nv3BE6ttRwyYTtS1a0oaz3ooiDP7eHQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] lib/string.c: add __sysfs_match_string_with_gaps() helper
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Dec 22, 2020 at 3:43 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Dec 22, 2020 at 3:09 PM Alexandru Ardelean
> <alexandru.ardelean@analog.com> wrote:
> >
> > The original docstring of the __sysfs_match_string() and match_string()
> > helper, implied that -1 could be used to search through NULL terminated
> > arrays, and positive 'n' could be used to go through arrays that may have
> > NULL elements in the middle of the array.
> >
> > This isn't true. Regardless of the value of 'n', the first NULL element in
> > the array will stop the search, even if the element may be after a NULL
> > element.
> >
> > To allow for a behavior where we can use the __sysfs_match_string() to
> > search over arrays with NULL elements in the middle, the
> > __sysfs_match_string_with_gaps() helper is added.
> > If n > 0, the search will continue until the element is found or n is
> > reached.
> > If n < 0, the search will continue until the element is found or a NULL
> > character is found.
>
> I'm wondering if we can leave __sysfs_match_string() alone (w/o adding
> unnecessary branch).

Works for me.
Will re-spin.

>
> int __sysfs_match_string_with_gaps(const char * const *array, size_t
> n, const char *str)
> {
>        const char *item;
>        int index;
>
>        for (index = 0; index < n; index++) {
>                item = array[index];
>                if (!item)
>                        continue;
>                if (sysfs_streq(item, str))
>                        return index;
>        }
>        return -EINVAL;
> }
>
> Note, the check n>0 seems redundant for this particular function.
>
> > +static int __sysfs_match_string_common(const char * const *array, ssize_t n,
> > +                                      const char *str, bool gaps)
> > +{
> > +       const char *item;
> > +       int index;
> > +
> > +       for (index = 0; index < n; index++) {
> > +               item = array[index];
> > +               if (!item) {
> > +                       if (gaps && n > 0)
> > +                               continue;
> > +                       break;
> > +               }
> > +               if (sysfs_streq(item, str))
> > +                       return index;
> > +       }
> > +
> > +       return -EINVAL;
> > +}
> > +
> >  /**
> >   * __sysfs_match_string - matches given string in an array
> >   * @array: array of strings
> > @@ -770,21 +790,32 @@ EXPORT_SYMBOL(match_string);
> >   */
> >  int __sysfs_match_string(const char * const *array, size_t n, const char *str)
> >  {
> > -       const char *item;
> > -       int index;
> > -
> > -       for (index = 0; index < n; index++) {
> > -               item = array[index];
> > -               if (!item)
> > -                       break;
> > -               if (sysfs_streq(item, str))
> > -                       return index;
> > -       }
> > -
> > -       return -EINVAL;
> > +       return __sysfs_match_string_common(array, n, str, false);
> >  }
>
> --
> With Best Regards,
> Andy Shevchenko
