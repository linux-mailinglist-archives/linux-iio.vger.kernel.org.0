Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8CCDCEEB
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2019 21:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394719AbfJRTDg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Oct 2019 15:03:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727542AbfJRTDg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Oct 2019 15:03:36 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E9622070B;
        Fri, 18 Oct 2019 19:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571425416;
        bh=ubV123RqqenurpEa3sSokdKx9rSLn257xx1N/l/X6+g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UchkUeHTvKM7gB9VJUtfkmNJkOcQzBZ+uHZmQN5I7F7P6IC95FmYMhnJ52YPc1REP
         p7th1Sj818nH6b/hywrjmVyMzhjf3TiqiDjgIUxYw6GIj+QSCIl67JQK4Cs591Qd2N
         OgwIFCsONjsIvMNP2WfCqFjWlyiQPBKZxK5nptRQ=
Date:   Fri, 18 Oct 2019 20:03:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: adc: cpcap-adc: Fix missing IRQF_ONESHOT as only
 threaded handler.
Message-ID: <20191018200331.42752066@archlinux>
In-Reply-To: <20191016172447.GT5607@atomide.com>
References: <20191013162133.1999362-1-jic23@kernel.org>
        <20191016172447.GT5607@atomide.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Oct 2019 10:24:47 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * jic23@kernel.org <jic23@kernel.org> [191013 16:24]:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Coccinelle noticed:
> > CHECK   drivers/iio/adc/cpcap-adc.c
> > drivers/iio/adc/cpcap-adc.c:1009:9-34: ERROR: Threaded IRQ with no primary handler requested without IRQF_ONESHOT
> > 
> > As far as I can see this is a simple case of it should be specified
> > but isn't.  
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobulders to play with it

Thanks,

Jonathan


