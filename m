Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF3AB173FA4
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2020 19:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgB1SdJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Feb 2020 13:33:09 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44590 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgB1SdJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Feb 2020 13:33:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id a14so1918758pgb.11
        for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2020 10:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k7elLN0P/2sWkQ7Okf82XTi+C7YjDHNb+LjdFZgm328=;
        b=ggYUiKfV6PHjnJgtOqTet19x3CvEbkQKarvQDEAojY02zTdLGM8dkIFa4fOob5O3fA
         bQhwpSM9+/wWOQLZKe+RCu2UHsUEIA4fOYb+WMk1yk+ShImV6cYoIcLcQCU/KwbYwTT/
         NhPQ6qphLotLlfXaAtAmmIJfjsxPxTEj/YHj2Cy2Tpqsz4vFt6pE17AMzeLmhSJvw3xX
         mZ35CwkpYN/aZULHSIiZqXQvV9YIB+hVcho3H3KZFPdhkRwJpLyF1kdHWSVx6i0uoFVe
         lfDxRpDudlz1zMWdRv+r7IG8YTTA9wSV2wu4ad6ORya+MHASiybwJIzTgE687nIznyeP
         pv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k7elLN0P/2sWkQ7Okf82XTi+C7YjDHNb+LjdFZgm328=;
        b=OriuK6iK019DHxt/eZXulfUIuwSv2VVRSlNwFN6BsRle3OHO4HSa3LBc+PVFOOn3Qh
         mQODhBil5ubSmJBa9TywWjZmvBbuVSCn0g3fDQy+45xFGBkEPRWkxvL79blIxnMgNSbW
         A+QkNIMqdPZW9vKRnwJeJMIsA1wTbSJde8w9EZM7OtQ+pBxM5o7EQ0d66GK0xdfzx4ME
         qClxkVe+cI8ngNBAsBnOmsZlj4NZob8QoBl2kJQZTexwAdMRCC+ZcEOVAQxqaPFvhwnK
         mQHma+VodVrsJNoib1pj0sfkRybTGyn6/sc5T1kDd6CEHWnSnbY1ObyrC85T8FjAhrBu
         r48Q==
X-Gm-Message-State: APjAAAXwZ9AlmbID2dzJXwRWDAOLAm4c3/NuagJh1Xoi0E3pq2PoKFpJ
        WIJC3mWbZjHZ4QERxOXu1toTNyrpMkTiQw==
X-Google-Smtp-Source: APXvYqwIr7AmnUI0U19W0/VVYd5SNDl3Gk3KSuyHZ1nRnayJO+IKZcJ3wpfRbQqgCN3KoOjX6C5h5g==
X-Received: by 2002:aa7:98c6:: with SMTP id e6mr5660284pfm.251.1582914788061;
        Fri, 28 Feb 2020 10:33:08 -0800 (PST)
Received: from SARKAR ([2401:4900:3314:1957:399a:a833:fab3:83b])
        by smtp.gmail.com with ESMTPSA id 129sm7303096pgf.10.2020.02.28.10.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 10:33:07 -0800 (PST)
Message-ID: <5e595ce3.1c69fb81.b955f.2891@mx.google.com>
X-Google-Original-Message-ID: <20200228183300.GA20947@rohitsarkar5398@gmail.com>
Date:   Sat, 29 Feb 2020 00:03:00 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: max1363: replace mlock with own lock
References: <5e5813b9.1c69fb81.e3d1a.5426@mx.google.com>
 <519965df20014e135acc9cc9c4674bbba8d76f1a.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <519965df20014e135acc9cc9c4674bbba8d76f1a.camel@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Feb 28, 2020 at 07:56:14AM +0000, Ardelean, Alexandru wrote:
> On Fri, 2020-02-28 at 00:38 +0530, Rohit Sarkar wrote:
> > This change replaces indio_dev's mlock with the drivers own lock. In
> > each case the lock is needed to protect the driver's own state.
> > 
> > Changes from v1:
> > Fix indentation.
> > Add a mutex_init() in the probe function.
> > 
> 
> This looks like the first patch.
> I don't see the code changes from the first one.
> 
I messed up sorry. Sent out v2 again.
Thanks,
Rohit
