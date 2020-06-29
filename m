Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF77920D38F
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jun 2020 21:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgF2TAL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Jun 2020 15:00:11 -0400
Received: from muru.com ([72.249.23.125]:59958 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbgF2TAK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Jun 2020 15:00:10 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4DE768188;
        Mon, 29 Jun 2020 15:22:06 +0000 (UTC)
Date:   Mon, 29 Jun 2020 08:21:11 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 08/23] iio:adc:cpcap-adc: Drop of_match_ptr protection
 and use device_get_match_data
Message-ID: <20200629152111.GO53169@atomide.com>
References: <20200628123654.32830-1-jic23@kernel.org>
 <20200628123654.32830-9-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628123654.32830-9-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

* Jonathan Cameron <jic23@kernel.org> [200628 12:40]:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Part of a slow effort to avoid OF specific code in IIO.
> 
> Whilst the main advantages of this are not likely to be seen in this
> particular driver (ACPI support via PRP0001) the change proposed
> does make things a bit more maintainable and also ensures that
> this particular (now) anti-patern is less likely to be cut and
> paste into new drivers.

Acked-by: Tony Lindgren <tony@atomide.com>
