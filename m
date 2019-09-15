Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 908B6B313F
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 19:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbfIORuD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 13:50:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33369 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbfIORuD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2019 13:50:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so21227774pfl.0;
        Sun, 15 Sep 2019 10:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+FT6t6tAgH2CWVt57WKWzQSYmQRrb9LBfWstrY+JJng=;
        b=nrm2wxkoyTJfutAKqZznB9wT9McfPgYJgWH5h1qWlOVl9xDWz+4MLH7RQKX1YY/9wH
         QnM/PA7CaQCqiT/qoaJViSSP4UqiGGPH0oEMBtYTQTtFnd3N5OdLHrtzkF3KcMY3X9CJ
         f0pnJhBQNNbBc78/UoWFyfS1WXCejvAi+LmYRQi+zyB1SczOQTRDSrofYP2WPHrV0iaW
         O+snJtRQjvUCGXx+Ocb9BuOlnB8Dg9XMau7caOcUINLPHyIabFJ1/4FkYttSougQpWkU
         IY9kj02ubIlWnI7iUEKC/AZ+Acdk1EaWESsdMpBVga7w0m+iG5yi4xKmjvL9idEggeFo
         nfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+FT6t6tAgH2CWVt57WKWzQSYmQRrb9LBfWstrY+JJng=;
        b=DR0cBIGlLP6QfRUivJPBPWTBbkycgwAvFGv28t8PsoQ7f6YJbXK2fvcUwH2pyuf1gx
         0tP1CbU8jzn9xHg6H+jKIqNt3hbvc2ax7mslDW23ptVYHUPow2qHBPPxPUZTWc+9jAJa
         Yl5RWXVwvq0W4/Ok2CbD/vTcYOaCnDNzoa/KhH09o6vhzYPALQP/cu6d/pRoNA2q9t/9
         bjmxxXbj77KmxPyARP6I2tbT3SDaMWmj2pA2u15TP+DocvUgI3ZmXlQ/UfDopUT6mxZC
         w4TJywK//fRcdBB+UrkyRa+T4tYJeBVcvH7/b7u01e5Ot8TWjjzTu+msrpFvEt7EBVX5
         /PtA==
X-Gm-Message-State: APjAAAWwQAKdQ+4AC6sD8vJD0++uhilr4tKM9/YKcwZdv5EdY1nPYcJg
        V0J6HwUBWnJD2LbAovz473X7KZHZLDiajA==
X-Google-Smtp-Source: APXvYqxkFf79p8GWOY6U+WCEFFhYXhudX7QAcO6HQGVHzKHtn9RAgVMjxoAfD1HhlcB+8b58eYV6Lg==
X-Received: by 2002:a63:487:: with SMTP id 129mr26134434pge.14.1568569801258;
        Sun, 15 Sep 2019 10:50:01 -0700 (PDT)
Received: from SARKAR ([1.186.12.73])
        by smtp.gmail.com with ESMTPSA id c1sm60759116pfb.135.2019.09.15.10.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 10:50:00 -0700 (PDT)
Date:   Sun, 15 Sep 2019 23:19:54 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        gregkh@linuxfoundation.org, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Rodrigo Carvalho <rodrigorsdc@gmail.com>
Subject: Re: [PATCH] staging: iio: ADIS16240: Remove unused include
Message-ID: <20190915174954.GA8247@SARKAR>
References: <20190913203627.GA1320@SARKAR>
 <20190915105300.12cc105f@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190915105300.12cc105f@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Sep 15, 2019 at 10:53:00AM +0100, Jonathan Cameron wrote:
> On Sat, 14 Sep 2019 02:06:27 +0530
> Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
> 
> > Bcc: 
> > Subject: [PATCH] staging: iio: adis16240: remove unused include
> > Reply-To: 
> Something odd happened here with patch formatting.  I fixed it up and
> applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.
> 
> Thanks,
> 
> Jonathan
> 

That's my bad, must have messed up while copying over the recipients
from another thread.

Thanks,
Rohit
