Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA5418EC8B
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 22:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgCVVRU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 17:17:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34940 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCVVRT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 17:17:19 -0400
Received: by mail-pl1-f196.google.com with SMTP id g6so5008654plt.2
        for <linux-iio@vger.kernel.org>; Sun, 22 Mar 2020 14:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WU59uSxYxquu5W8uZXDT9C61AEGpyQ0OwOzf7s1/ZvY=;
        b=Y66WU1RIo40huh//7ux+8ij/5ExSq3+khvhGpY3IKaJUAUjn3QdjSUnxSypo+VSfM5
         XAhNdtzQrRgN+C7hwxSsYMw/f0jlcXR6jCBmeYzGKRD10VVEaCPWHYsykfOMC7+sCK0c
         GkKG6+vtaBmYGSdXHB6uuWKgmBFS2hYIDFIqC9F7c+Fh0mRLkdNKIXL+ZQHkZ2Yf5OGk
         3aQtQRf0tHCoHgVzSRlsuk460jhYwhuNqwhg8gP0Mo2V39H12jDoaM0fniJfxk77dDGd
         w06rDUvQk37BNv6qRal+GzoaX+fH0A61qhKyfKf1CHRZOxdir0uH2YtDRdk+4Oz7b0uy
         FmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WU59uSxYxquu5W8uZXDT9C61AEGpyQ0OwOzf7s1/ZvY=;
        b=qeUuA8GCIzfkeceQ5so8rDvQIa1K9gRqHmRWR0ULpiIm3aEsSgbodUIW91kI9eRii0
         zDVFNak0CvUat0uFi47Va5ZIz7pft+uGMBXuh1PGZDxQ2uPspwCEb0NRso6kP8vlmm6H
         poz/jR2/wqPKZgtc4pyx/98Xh//sIAUEjFqi8a0sQdE4vjDqNY/Veb7D6cyeMpcB9jUL
         N/953mg35Nzll82vTeHjtqkUc9OcJeQtTFmeR9tvMyvOLWawADb8ha4DcAYfwk5t9BoS
         eNPpDfvWCi82xzsimXbfyABOCOEejq0q+qV0r1NsxLy6ftZf/EFRS+jmS2abCYv9R6G5
         nA2Q==
X-Gm-Message-State: ANhLgQ0BMq0Y5rLawDHK1OROcGlM2yfUmPQd+Ulx827W5pDGLKTkOnfA
        mBoMFNM2vyHwGbdTjLLgc9iEhp/g8UvuLk8uLLg=
X-Google-Smtp-Source: ADFU+vvubNCgEyq45zRpFaihWpD/yu+yniYwGVzRtg/j7HQQYVnXrXvPaoRjTqPcx5w2cflcRBI0ldTS3zr/PHaURoE=
X-Received: by 2002:a17:902:b096:: with SMTP id p22mr13462420plr.262.1584911838972;
 Sun, 22 Mar 2020 14:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200317101813.30829-1-andriy.shevchenko@linux.intel.com>
 <20200317101813.30829-2-andriy.shevchenko@linux.intel.com> <20200322171617.5b176335@archlinux>
In-Reply-To: <20200322171617.5b176335@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 22 Mar 2020 23:17:07 +0200
Message-ID: <CAHp75VdzZeSDtw7ZZ_XwqEEcmYH7t1ifvOAwGNr0T5=BQsud7g@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] iio: pressure: bmp280: Use IIO_DEVICE_ATTR_RO macro
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 22, 2020 at 7:17 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 17 Mar 2020 12:18:10 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > Use the IIO_DEVICE_ATTR_RO macro to create the device attributes.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Hmm. Minor gain but fair enough I guess.
>
> Could consider using the core support _available attributes instead.
>
> I'm not usually fussy about moving drivers over to that unless we have
> an in kernel consumer, but if you are going to touch the code it
> might be nice to move to them :)

Any good driver as an example? Or even conversion change done for one?

-- 
With Best Regards,
Andy Shevchenko
