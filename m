Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23648D262D
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2019 11:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387653AbfJJJVx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Oct 2019 05:21:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387463AbfJJJVw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Oct 2019 05:21:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F16362064A;
        Thu, 10 Oct 2019 09:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570699312;
        bh=3nYw7DfoHOxoDFq9RSLM6LNENfiiUWo//itoqzQW0wA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=15qrmQtTJjqf51pOD9sX0sWzO3e8bTfRXsS4mcVBpI+hi9kyo5Kgw73Mr80ymSzg3
         3gNeJKShncwN/SEM7McJz4mH8+GfbLC139o5dmUA199Ot6No10bd+0/qnLtUBKvq1b
         8IAOFrKTGoyf8/OrBng1MIgrzzvZo8pcc9Fpmx44=
Date:   Thu, 10 Oct 2019 11:21:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 1st set of IIO fixes for the 5.4 cycle.
Message-ID: <20191010092150.GA527071@kroah.com>
References: <20191009193239.694ff6ab@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009193239.694ff6ab@archlinux>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Oct 09, 2019 at 07:32:39PM +0100, Jonathan Cameron wrote:
> The following changes since commit b33f56a1e40588214320926293585f088fb390b0:
> 
>   staging: rtl8723bs: hal: remove redundant variable n (2019-09-06 18:20:33 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.4a

Pulled and pushed out, thanks.

greg k-h
