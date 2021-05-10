Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158B137850E
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 13:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhEJK6V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 06:58:21 -0400
Received: from onstation.org ([52.200.56.107]:33066 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232566AbhEJKxP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 May 2021 06:53:15 -0400
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 May 2021 06:53:15 EDT
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 6073A3EA89;
        Mon, 10 May 2021 10:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1620643561;
        bh=CbaE/GF/QslahXGEahOEcUqhikEVADnK9q1gj0ip75Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pAEW8Yg+oli7YZxsMlpa1k7OieYwjxT7ecSZmhe+ZEQvUxF1zWu7XmhOHiHujSFXB
         kZplJwKEy12WMLNVNyMoWQtDpHxqhyByVmdMzcRgKrhmf7gDnifQG9hYE5PlUQin4f
         0e3HtcqQI9tVsWifTj/Z8cdGBuXemaOG6HF1M/eI=
Date:   Mon, 10 May 2021 06:46:01 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 03/28] iio: light: tsl2583: Balance runtime pm + use
 pm_runtime_resume_and_get()
Message-ID: <20210510104601.GB296@onstation.org>
References: <20210509113354.660190-1-jic23@kernel.org>
 <20210509113354.660190-4-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210509113354.660190-4-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 09, 2021 at 12:33:29PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Error paths in read_raw() and write_raw() callbacks failed to perform and
> type of runtime pm put().  Remove called pm_runtime_put_noidle()
> but there is no equivalent get (this is safe because the reference
> count is protected against going below zero, but it is misleading.
> 
> Whilst here use pm_runtime_resume_and_get() to replace boilerplate.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Brian Masney <masneyb@onstation.org>

Reviewed-by: Brian Masney <masneyb@onstation.org>

