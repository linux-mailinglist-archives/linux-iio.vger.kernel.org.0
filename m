Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56B038B81B
	for <lists+linux-iio@lfdr.de>; Thu, 20 May 2021 22:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbhETUJ7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 May 2021 16:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbhETUJ7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 May 2021 16:09:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90876C061574;
        Thu, 20 May 2021 13:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RL+lK8usZm6e87x0wg/qqwwNxRjGH9Tsz6E4tKt5SYE=; b=rcmKoR4bFCQU44vlSTobZtpEC2
        Zzh9uexgE/GLYgHvVKOgINb/ENNSyNbOaPl95yABDWzCaPWuPbnJeuOrfPCIPlp0LUTsiL9gkkT2f
        2B2w+LOKCty+s3QIzinmLT118Szbu7Uy9vslU5uSWrm5i6qs8nLzEMgKasd+jPrtph/stfc4PJLlG
        ve6kEQ12kF8iYLlp2D8Kg5XIJoHPk/tuE1RLe0786dAMTJNfQFTp+AnyWjYjKkfCjxczWE01eeH6E
        S+zw5e5T7FMnLgzQLKAs0u5PjJGH9sPs1in+lEKoRN0TIZmb8du0TCrWe4M0li8wZCjP82XlBKbel
        wA0NYxlg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljoxs-00GMAg-31; Thu, 20 May 2021 20:08:23 +0000
Date:   Thu, 20 May 2021 21:08:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] iio: documentation: fix a typo
Message-ID: <YKbBsOnQyThisWDP@casper.infradead.org>
References: <cover.1621413933.git.mchehab+huawei@kernel.org>
 <ebe6c6597409fb9748e6c05d8e8cb3bd3fa4c6f4.1621413933.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebe6c6597409fb9748e6c05d8e8cb3bd3fa4c6f4.1621413933.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 19, 2021 at 10:51:47AM +0200, Mauro Carvalho Chehab wrote:
> @@ -798,7 +798,7 @@ What:		/sys/.../in_capacitanceY_adaptive_thresh_rising_timeout
>  What:		/sys/.../in_capacitanceY_adaptive_thresh_falling_timeout
>  KernelVersion:	5.11
>  Contact:	linux-iio@vger.kernel.org
> -Descrption:
> +Description:
>  		When adaptive thresholds are used, the tracking signal
>  		may adjust too slowly to step changes in the raw signal.
>  		*_timeout (in seconds) specifies a time for which the

This must be the warning Jon refers to.  * as wildcard, rather than
* as emphasis marker.
