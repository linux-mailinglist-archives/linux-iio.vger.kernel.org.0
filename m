Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30C22D9888
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2019 19:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389072AbfJPRc7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Oct 2019 13:32:59 -0400
Received: from muru.com ([72.249.23.125]:37598 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388899AbfJPRc7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Oct 2019 13:32:59 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id DD3F48107;
        Wed, 16 Oct 2019 17:25:24 +0000 (UTC)
Date:   Wed, 16 Oct 2019 10:24:47 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: adc: cpcap-adc: Fix missing IRQF_ONESHOT as only
 threaded handler.
Message-ID: <20191016172447.GT5607@atomide.com>
References: <20191013162133.1999362-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013162133.1999362-1-jic23@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

* jic23@kernel.org <jic23@kernel.org> [191013 16:24]:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Coccinelle noticed:
> CHECK   drivers/iio/adc/cpcap-adc.c
> drivers/iio/adc/cpcap-adc.c:1009:9-34: ERROR: Threaded IRQ with no primary handler requested without IRQF_ONESHOT
> 
> As far as I can see this is a simple case of it should be specified
> but isn't.

Acked-by: Tony Lindgren <tony@atomide.com>
