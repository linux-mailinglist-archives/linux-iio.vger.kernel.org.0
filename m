Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CF22E0AFE
	for <lists+linux-iio@lfdr.de>; Tue, 22 Dec 2020 14:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgLVNmp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Dec 2020 08:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgLVNmo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Dec 2020 08:42:44 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10F5C0613D3;
        Tue, 22 Dec 2020 05:42:04 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id n25so2869271pgb.0;
        Tue, 22 Dec 2020 05:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DKstfCrObaRIVnqNYrHwR48s9bbWISBjfF34z/wJe/E=;
        b=oCBl7iB7PMfcwhhQw64sG0dJ6RT8pDv0C6PS50UNZMli/J5vz8kXBoaB75lrFuBzBp
         tlg7Le/pB2rD+9WTcUXtf7IaFiJTeaERbM8wwywdzky2HJQRl84Zvvr71KpT5Gq+3WM4
         b04nyYeacZvAoWVnXCUxKg+/V/HrE/usT5NzTEzx8SMVmAYL1IAlYRGNtIHD8EcvEBgK
         HELLecUMqnWpzDWXLP6xnF4sKM1cUaLFfj4EWi8P9GMtX6PZVsFb8j45HSupcmYI1zhG
         pS7JnTYltmjyDmRA8c15lY6zaLiiy1KuqpoQGRc6HNsk8kavPFGAuS8V80chNswu8JYR
         QCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DKstfCrObaRIVnqNYrHwR48s9bbWISBjfF34z/wJe/E=;
        b=U43twcgQ4E4vNtggHL5HcTJVbj3niVdUo48rbzI2l3qG4+ARl/SnV9mz+V7xaBYW0z
         7n2EpDLlx5Ga7AantmIjb8g6DqXxVb9d+tMmvDRbst5s0Y8KVvr8622pZBQ62ghqYGxb
         72hyJ3g3Tm8J4X4zhtsV0a1C8vFws56BuJdA1fTCxYbQj5lfFkHrMygVaYY5eflJHV8n
         4GIqCheKMVnLl9o5KukUtB1eas+HG4rlEl9r4HhIGUyFQoAtcTEAUrW7AjVO6yIvhbWd
         CMo8m6mjC+VW2PHAekO38BtZK+nqch3CrEhsSGgfgZiGaJLnvqhpzt72A7t+10xe1b97
         187Q==
X-Gm-Message-State: AOAM531KFYV1nQrPnHtfVxkwyCoSAo2EOi5CIRI+Gvmq4cOSXS+x4jeP
        Rh+geYQsTZzi3v6OFOK1ZFRg1iqLgGlLeTe/Nn8=
X-Google-Smtp-Source: ABdhPJzpY3/aKsMoLdWp7h3b2adg/iZaJX9Avp3qIUV0USJTNTDkvMwSKaZTSqcs9UTPxQuG554ia4SkNDbTtlQs0Fs=
X-Received: by 2002:a63:74b:: with SMTP id 72mr19918744pgh.4.1608644524210;
 Tue, 22 Dec 2020 05:42:04 -0800 (PST)
MIME-Version: 1.0
References: <20201222131312.64957-1-alexandru.ardelean@analog.com>
In-Reply-To: <20201222131312.64957-1-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 22 Dec 2020 15:42:52 +0200
Message-ID: <CAHp75Ve06gYFE+U_XNZfTFceMEzmADR6wd0OYr+tVMQ6hW3MLQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] lib/string.c: add __sysfs_match_string_with_gaps() helper
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Dec 22, 2020 at 3:09 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> The original docstring of the __sysfs_match_string() and match_string()
> helper, implied that -1 could be used to search through NULL terminated
> arrays, and positive 'n' could be used to go through arrays that may have
> NULL elements in the middle of the array.
>
> This isn't true. Regardless of the value of 'n', the first NULL element in
> the array will stop the search, even if the element may be after a NULL
> element.
>
> To allow for a behavior where we can use the __sysfs_match_string() to
> search over arrays with NULL elements in the middle, the
> __sysfs_match_string_with_gaps() helper is added.
> If n > 0, the search will continue until the element is found or n is
> reached.
> If n < 0, the search will continue until the element is found or a NULL
> character is found.

I'm wondering if we can leave __sysfs_match_string() alone (w/o adding
unnecessary branch).

int __sysfs_match_string_with_gaps(const char * const *array, size_t
n, const char *str)
{
       const char *item;
       int index;

       for (index = 0; index < n; index++) {
               item = array[index];
               if (!item)
                       continue;
               if (sysfs_streq(item, str))
                       return index;
       }
       return -EINVAL;
}

Note, the check n>0 seems redundant for this particular function.

> +static int __sysfs_match_string_common(const char * const *array, ssize_t n,
> +                                      const char *str, bool gaps)
> +{
> +       const char *item;
> +       int index;
> +
> +       for (index = 0; index < n; index++) {
> +               item = array[index];
> +               if (!item) {
> +                       if (gaps && n > 0)
> +                               continue;
> +                       break;
> +               }
> +               if (sysfs_streq(item, str))
> +                       return index;
> +       }
> +
> +       return -EINVAL;
> +}
> +
>  /**
>   * __sysfs_match_string - matches given string in an array
>   * @array: array of strings
> @@ -770,21 +790,32 @@ EXPORT_SYMBOL(match_string);
>   */
>  int __sysfs_match_string(const char * const *array, size_t n, const char *str)
>  {
> -       const char *item;
> -       int index;
> -
> -       for (index = 0; index < n; index++) {
> -               item = array[index];
> -               if (!item)
> -                       break;
> -               if (sysfs_streq(item, str))
> -                       return index;
> -       }
> -
> -       return -EINVAL;
> +       return __sysfs_match_string_common(array, n, str, false);
>  }

-- 
With Best Regards,
Andy Shevchenko
