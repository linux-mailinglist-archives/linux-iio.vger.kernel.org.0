Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23C01EE1D9
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2019 15:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfKDOGs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Nov 2019 09:06:48 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:48669 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbfKDOGs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Nov 2019 09:06:48 -0500
Received: from 122.62-97-226.bkkb.no ([62.97.226.122]:10220 helo=[10.0.1.54])
        by smtp.domeneshop.no with esmtpa (Exim 4.92)
        (envelope-from <eugene.zaikonnikov@norphonic.com>)
        id 1iRd0H-00084X-T1; Mon, 04 Nov 2019 15:06:45 +0100
Subject: Re: [PATCH 0/1] Add support for TI HDC200x humidity and temperature
 sensors
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        development@norphonic.com, linux-iio@vger.kernel.org
References: <71176abd-4997-70f8-8132-137fadda7768@norphonic.com>
 <20191103121921.5b1d0b02@archlinux>
From:   Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
Organization: Norphonic AS
Message-ID: <11967ef7-7d25-de92-5e73-2c35b69e8454@norphonic.com>
Date:   Mon, 4 Nov 2019 15:06:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191103121921.5b1d0b02@archlinux>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 03.11.2019 13:19, Jonathan Cameron wrote:
>
> Various comments inline. 

Thanks for these. The driver was developed in our internal older branch so has some idiosyncrasies due to that, plus certain beginnings for the chip features that we haven't come around to add full support yet. Will clean up those and re-submit.


--
  Eugene.
