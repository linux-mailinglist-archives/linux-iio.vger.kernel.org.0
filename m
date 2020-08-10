Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DDD240464
	for <lists+linux-iio@lfdr.de>; Mon, 10 Aug 2020 11:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgHJJ61 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Aug 2020 05:58:27 -0400
Received: from mailout12.rmx.de ([94.199.88.78]:56707 "EHLO mailout12.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbgHJJ60 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 Aug 2020 05:58:26 -0400
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout12.rmx.de (Postfix) with ESMTPS id 4BQBHM3FBQzRkq5;
        Mon, 10 Aug 2020 11:58:23 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4BQBH65lWPz2xbQ;
        Mon, 10 Aug 2020 11:58:10 +0200 (CEST)
Received: from n95hx1g2.localnet (192.168.54.71) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 10 Aug
 2020 11:57:47 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Pavel Machek <pavel@ucw.cz>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: documentation: light: Add as73211 sysfs documentation
Date:   Mon, 10 Aug 2020 11:57:46 +0200
Message-ID: <4688751.agSyimv0uN@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20200810090054.GA8495@localhost>
References: <20200808171443.114c8e05@archlinux> <20200809074335.23734-1-ceggers@arri.de> <20200810090054.GA8495@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.71]
X-RMX-ID: 20200810-115812-4BQBH65lWPz2xbQ-0@kdin01
X-RMX-SOURCE: 217.111.95.66
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Monday, 10 August 2020, 11:00:54 CEST, Pavel Machek wrote:
> Hi!
> 
> > The driver for the as73211 light sensor provides the following not yet
> > documented sysfs entries:
> > - in_intensity_(x|y|z)_raw
> > - in_intensity_(x|y|z)_scale
> > - in_intensity_sampling_frequency(_available)
> > - in_intensity_hardwaregain(_available)
> 
> Should that be hardware_gain ?
drivers/iio/industrialio-core.c:
[IIO_CHAN_INFO_HARDWAREGAIN] = "hardwaregain",

> 							
Pavel
regards
Christian





