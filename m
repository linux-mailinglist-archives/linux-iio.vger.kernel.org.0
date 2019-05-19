Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCA6722864
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 20:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfESSnl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 May 2019 14:43:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45919 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfESSnl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 May 2019 14:43:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id a5so5626664pls.12;
        Sun, 19 May 2019 11:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6m7D+bu1zYRC0v/E1KNNwrtOsTcyu17DCNJXsbLJmfY=;
        b=QtBju1AYMkQXi6pcqrAXtCcB3Sp/497azLfG5iatmvikg/hpypk2TcDmAtx+Z+4YPd
         31H5wfz0LeIcfCoMVFRbwUIkU0WGIJeI8sNGvwcc4kvRYgSwSWie+IVyTdoHY/F164p0
         sqEBBaNq7nb/LLo604WIIUp3qXVos2Eczj/1G7iaYgKX+7NAgxsP0PlZs34Q7XYlS0P4
         8AX4izF6LRoahsmLnUKEyd+OCt3Fsi5Vpl4hKdMyOpO7D1sRNhh0ZLsViv4ArLO0Dzj5
         GuUSkaOBeqg21lpGs+vH8rOeYE2+nTzdthBBFgg9gGFUu0ibmaK/zP9SWCN82qQWmvt/
         wn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6m7D+bu1zYRC0v/E1KNNwrtOsTcyu17DCNJXsbLJmfY=;
        b=Mv+UiuoPkvYxTPDnl9BbCnqTtn0XqMsWCiTtYfjFr31IKxPj2M/dqaPHjoGG9/tNXG
         bdU6y1ak4tNg2YzXiT/pshFHl9c0KdUt3rJQESgcGVgZalhSABP8t1MMVowpRJ+TjT4v
         XBL42l6u9iXbqVmvKC86Bz2v8YeCh8q8q94H5npkCaFQvFR+1S9U8XY8FH4ZotQ2lXI2
         fOCZ1nIEpTAn5EFbaVlbqG1a+I0hT9L7iRxAoKzc7diq7lypXcpu7IWYZIsRac6nCicD
         hFBQ0WVqwG2jY7aVUv+4xqWyLRAkHnzZBgOuxd6l8ueQEAth70Ow1qzqXcvdqPV6YIp8
         U6cQ==
X-Gm-Message-State: APjAAAUeff62E/otr5mETwBX23s5rHOJ7eVP8H+MNHEIRicsRDfdy0L4
        NyzO2UGxZpjEjCWiMvbAgk2TC1EPY+o=
X-Google-Smtp-Source: APXvYqyyTPdDvkdqCQv7W9NIjj7S0OuOv4xAQVr7r+33dAZbQb0c67SZZjkt5X9wDpV3Cm2ip+y+hw==
X-Received: by 2002:a17:902:b713:: with SMTP id d19mr7121413pls.123.1558240428936;
        Sat, 18 May 2019 21:33:48 -0700 (PDT)
Received: from icarus ([2001:268:c1c3:c593:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id j12sm14569207pff.148.2019.05.18.21.33.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 May 2019 21:33:47 -0700 (PDT)
Date:   Sun, 19 May 2019 13:33:30 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH -next] counter: fix Documentation build error due to
 incorrect source file name
Message-ID: <20190519043313.GA20933@icarus>
References: <b6475070-f336-1093-ff0f-6bc8d5fda35e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b6475070-f336-1093-ff0f-6bc8d5fda35e@infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 18, 2019 at 09:29:58PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kernel-doc build error in Documentation/driver-api/generic-counter.rst
> of incorrect source file name.
> Fixes this warning and error:
> 
> Error: Cannot open file ../drivers/counter/generic-counter.c
> WARNING: kernel-doc '../scripts/kernel-doc -rst -enable-lineno -export ../drivers/counter/generic-counter.c' failed with return code 2
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
> Cc: linux-iio@vger.kernel.org
> ---
>  Documentation/driver-api/generic-counter.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20190517.orig/Documentation/driver-api/generic-counter.rst
> +++ linux-next-20190517/Documentation/driver-api/generic-counter.rst
> @@ -251,7 +251,7 @@ for defining a counter device.
>  .. kernel-doc:: include/linux/counter.h
>     :internal:
>  
> -.. kernel-doc:: drivers/counter/generic-counter.c
> +.. kernel-doc:: drivers/counter/counter.c
>     :export:
>  
>  Implementation
> 
> 

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
