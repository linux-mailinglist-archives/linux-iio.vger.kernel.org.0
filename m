Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B366F3C8ACE
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jul 2021 20:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhGNS2P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 14:28:15 -0400
Received: from aibo.runbox.com ([91.220.196.211]:60484 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239899AbhGNS2O (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 14 Jul 2021 14:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbx.email;
         s=selector1; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date; bh=x1gHoNzyOe3SpuRdVPOxl7W3Rx56hGKvrqfF7PFLoOo=; b=b
        am+bnzZ+FoJbJJijm0jhjgMcWW/4Eu3Xc91oR4dgNkup4KmBSieoXxHFLWD1gHaGlPPSJB1G2tvX8
        t3hx7E8pyclzfxKpZXiYmlf2IP/FQOETZGvaEEjcwiIsPwCbV9BNcF1YQ/BnDae2ITvfhUsGnL3VW
        3C4Igq/57B5EnSNnnQPuNUUUiR40cyT/rw5GeLP93qqtayAAYGC9zDVqfUbwfHLSw70KlwHIX6OeL
        J3FeA7I794SkfneECwxX/8rI5p2zGkns9s0plDzKydrZtYuzQ5mqCDr596fWSMsUXwS6FICdyTGvM
        jQinxDG0lEMOO9iWc4C75Z6zrAReph4/Q==;
Received: from [10.9.9.73] (helo=submission02.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <detegr@rbx.email>)
        id 1m3jZI-0005fC-7j; Wed, 14 Jul 2021 20:25:12 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (932193)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1m3jZH-0002iS-77; Wed, 14 Jul 2021 20:25:11 +0200
Date:   Wed, 14 Jul 2021 21:25:07 +0300
From:   Antti =?utf-8?Q?Ker=C3=A4nen?= <detegr@rbx.email>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hannu Hartikainen <hannu@hrtk.in>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adis: set GPIO reset pin direction
Message-ID: <20210714182507.4263dvarll5geacl@haukka.localdomain>
References: <60e5ac8c.1c69fb81.c69f0.abab@mx.google.com>
 <20210708095425.13295-1-detegr@rbx.email>
 <20210713185311.200023ef@jic23-huawei>
 <20210714100445.hr73r2dfkxf36f35@haukka.localdomain>
 <20210714134005.00001322@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210714134005.00001322@Huawei.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 14, 2021 at 01:40:05PM +0100, Jonathan Cameron wrote:
> Send the fixes tag in reply to this and I'll make sure it's added.
> No need to bother with a v3 for just that.

Fixes: ecb010d44108 ("iio: imu: adis: Refactor adis_initial_startup")

-- 
Antti
