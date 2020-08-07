Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A49023F026
	for <lists+linux-iio@lfdr.de>; Fri,  7 Aug 2020 17:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgHGPrZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Aug 2020 11:47:25 -0400
Received: from mailout02.rmx.de ([62.245.148.41]:52337 "EHLO mailout02.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgHGPrZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 7 Aug 2020 11:47:25 -0400
Received: from kdin02.retarus.com (kdin02.dmz1.retloc [172.19.17.49])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout02.rmx.de (Postfix) with ESMTPS id 4BNV9P411szNldc;
        Fri,  7 Aug 2020 17:47:21 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin02.retarus.com (Postfix) with ESMTPS id 4BNV906GPlz2TRlS;
        Fri,  7 Aug 2020 17:47:00 +0200 (CEST)
Received: from n95hx1g2.localnet (192.168.54.12) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 7 Aug
 2020 17:46:37 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] iio: light: as73211: New driver
Date:   Fri, 7 Aug 2020 17:46:36 +0200
Message-ID: <4466981.tjO45I7u8z@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20200806184451.04293626@archlinux>
References: <20200805055744.31909-1-ceggers@arri.de> <20200805055744.31909-3-ceggers@arri.de> <20200806184451.04293626@archlinux>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.12]
X-RMX-ID: 20200807-174702-4BNV906GPlz2TRlS-0@kdin02
X-RMX-SOURCE: 217.111.95.66
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Thursday, 6 August 2020, 19:44:51 CEST, Jonathan Cameron wrote:
> Hi Christian,
> 
> I'll take this, but please send a follow up patch to add documentation
> for in_intensity_x_raw and all the other new ABI this adds in
> Documentation/ABI/testing/sysfs-bus-iio
> I should have mentioned that earlier, but kind of assumed we already
> had these documented for some reason!
where to add these entries in Documentation/ABI/testing/sysfs-bus-iio?
Shall all missing entries be added together at the bottom (as AS73211
is the first device using it) , or inserted in different existing paragraphs
(when the enums where introduced)?

Which kernel version shall I use (5.10)?

regards
Christian




