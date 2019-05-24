Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70F0C29944
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2019 15:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391553AbfEXNum (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 May 2019 09:50:42 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35671 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391124AbfEXNum (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 May 2019 09:50:42 -0400
Received: by mail-qk1-f196.google.com with SMTP id c15so7640585qkl.2;
        Fri, 24 May 2019 06:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p8F4WyQZW+GI44XlYkE2TwGfMqACxuEMgKBoIKdGQcU=;
        b=P3DLjgakvjT7EAxdRbyr6rciA5GOllMVOr5E5Qalw2k7kdxVQRBO5KJoQWjVXPFDbr
         2LXSXh/tlmEDqR3dnEYOWJQQSWQv2lcz+5gxg0hBY7wow5DpVBwYTPHNmreVZAKlNG8Q
         BSBG09n9QlR6TBvyRaeUp+zTs8Amn+Z2mMUFMZgSdR6LSvxLVnNwbmwlMbl0sk80WKo6
         6+NBDTPmQ72c6VgiwkRs7a4b9rQGKRWGPTtEQWwQgG6GipX6DyHgNpy6Ng+A7U0cek0M
         qcGoE0VWSc2W3m+uLHHttAPTwQH0MbqBUyh9oK2wiJhDAd6whVpsz1t8hvnYV+lXV+mX
         ytdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p8F4WyQZW+GI44XlYkE2TwGfMqACxuEMgKBoIKdGQcU=;
        b=LrY5xsBu/rBQW/NZvTaIqdhVMc0+Dh5ulkHr9d4WWCa55xgM9kDzlcS1p0ZYmdwxEk
         TszH7kl0VLuOcJMJSrKjOtu7lk1ecMDg3hoUcOoKk1jWKLA6OnnFbLZg/JyaW7/0gUb5
         7QfreZxA0Nz+yijyyjkLxP5n/GG7K6YQvi6UcWSaxUS8XEbw25lIOKl+lMRcST0vQ7E5
         Rf2K+qjauleaOzwuLOyq9nFNXjHDQ5Z883CkoLg4ig8B/Je3bbWtnEQauxl8AtXsFaM7
         vxUeAhp18g/NbxZIWTC/NRiMHO5461sEEgjm3M2nKNTQDtwGYBtf9TJetQVrItEB/Mkp
         jlAQ==
X-Gm-Message-State: APjAAAWYH3VR+EnN84oDHPPUMxLkJ3xwO0yWJYmzPuW0TcJNB1yqka1K
        GRHWgt7YzBY8L0aGt2N9r+o=
X-Google-Smtp-Source: APXvYqxIb7KnFdaoUvh+xhdTgH619i0pVWqH9VkoiettkG+ekigRjW25Pf0XMhomyWxIbx+I7n2LbQ==
X-Received: by 2002:ac8:2e74:: with SMTP id s49mr85793416qta.23.1558705841124;
        Fri, 24 May 2019 06:50:41 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id u2sm1064043qtq.45.2019.05.24.06.50.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 24 May 2019 06:50:40 -0700 (PDT)
Date:   Fri, 24 May 2019 10:50:35 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Rodrigo Ribeiro <rodrigorsdc@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-usp@googlegroups.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH] staging: iio: adis16240: add of_match_table entry
Message-ID: <20190524135034.u2mbtq2jwhp6ent7@smtp.gmail.com>
References: <20190524032950.2398-1-rodrigorsdc@gmail.com>
 <CA+U=DspqLFBMrRcV6VmypHOpE6Qs7OqmiDzWAd6pxpA7B=4S4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+U=DspqLFBMrRcV6VmypHOpE6Qs7OqmiDzWAd6pxpA7B=4S4g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Alexandru,

On 05/24, Alexandru Ardelean wrote:
> On Fri, May 24, 2019 at 6:30 AM Rodrigo Ribeiro <rodrigorsdc@gmail.com> wrote:
> >
> > This patch adds of_match_table entry in device driver in order to
> > enable spi fallback probing.
> >
> > Signed-off-by: Rodrigo Ribeiro <rodrigorsdc@gmail.com>
> > Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > ---
> >  drivers/staging/iio/accel/adis16240.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
> > index 8c6d23604eca..b80c8529784b 100644
> > --- a/drivers/staging/iio/accel/adis16240.c
> > +++ b/drivers/staging/iio/accel/adis16240.c
> > @@ -444,6 +444,7 @@ MODULE_DEVICE_TABLE(of, adis16240_of_match);
> >  static struct spi_driver adis16240_driver = {
> >         .driver = {
> >                 .name = "adis16240",
> > +               .of_match_table = adis16240_of_match,
> 
> This patch is missing the actual table.

Struct with compatible devices table was included separately in a
previous patch at commit d9e533b6c0a26c7ef8116b7f3477c164c07bb6fb.
Yeah, I also thought it was missing the match table the first time I was
this patch. It's really confusing when we have two patches, one
depending on another, that are not part of the same patch set. We're
trying to avoid things like this the most but that slipped out from our
internal review. We're sorry about that.

> 
> >         },
> >         .probe = adis16240_probe,
> >         .remove = adis16240_remove,
> > --
> > 2.20.1
> >
