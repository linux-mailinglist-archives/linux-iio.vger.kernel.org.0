Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD73426358E
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 20:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgIISGW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 14:06:22 -0400
Received: from mailout11.rmx.de ([94.199.88.76]:53510 "EHLO mailout11.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgIISGV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Sep 2020 14:06:21 -0400
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout11.rmx.de (Postfix) with ESMTPS id 4BmqhS4G7Bz41XB;
        Wed,  9 Sep 2020 20:06:16 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4Bmqh76S15z2xDp;
        Wed,  9 Sep 2020 20:05:59 +0200 (CEST)
Received: from n95hx1g2.localnet (192.168.54.12) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 9 Sep
 2020 20:05:26 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
CC:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] iio: light: as73211: New driver
Date:   Wed, 9 Sep 2020 20:05:06 +0200
Message-ID: <2755372.56de54GTkM@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20200903194352.38a4a850@archlinux>
References: <20200805055744.31909-1-ceggers@arri.de> <20200901194600.4e9e7db6@archlinux> <20200903194352.38a4a850@archlinux>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.12]
X-RMX-ID: 20200909-200605-4Bmqh76S15z2xDp-0@kdin01
X-RMX-SOURCE: 217.111.95.66
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

sorry for the delay, I was on holiday last week.

On Thursday, 3 September 2020, 20:43:52 CEST, Jonathan Cameron wrote:
> 
> I've done this halving change because I'm fairly sure it's right and want
> to get a clean report from 0-day before I do a pull request at the
> weekend.  Still time to change if anyone shouts quickly. If not
> there is still plenty of time for a fix.

looks correct for me.

Thanks
Christian




