Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542F73C8262
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jul 2021 12:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbhGNKHu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 06:07:50 -0400
Received: from aibo.runbox.com ([91.220.196.211]:46476 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238797AbhGNKHt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 14 Jul 2021 06:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbx.email;
         s=selector1; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date; bh=Lbn428M9zWIz6Kli8yF6lQh8yPqPwohmPjOnq9Mr5G8=; b=E
        To2SENFcX7zlaOHJYVlvtjK5NoOjUdqDzscmKVolPtLW0nnfOul3tKGKtRqKAzWOy5K7RAyUq4ZKA
        SFB/d8tQtTfu116pCtbYcRwnKsLj+pqojMJPgPzhs52xfuZselaKdda6X0VFu062U/RElLu+nLiNc
        IK/qhBYmh3i6bxPI3pA0X3C8eqNdgtk5qWhjt2vMwOZyWB9oh3Cy0Vml+XvY7XkBhKuroI5G9wnuv
        n9a2w9PQYdA+sThjWkgMhIXkz08I15805BxmpL8KtR1rLxl/iYp+QcV8+6zFSftJXM5yZG1ji7Oq4
        ps4loubObqXJM8EJSUCsv6w5BZAZOLKVw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <detegr@rbx.email>)
        id 1m3bl9-0008Mk-As; Wed, 14 Jul 2021 12:04:55 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (932193)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1m3bl4-0006EX-2L; Wed, 14 Jul 2021 12:04:50 +0200
Date:   Wed, 14 Jul 2021 13:04:45 +0300
From:   Antti =?utf-8?Q?Ker=C3=A4nen?= <detegr@rbx.email>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Hannu Hartikainen <hannu@hrtk.in>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adis: set GPIO reset pin direction
Message-ID: <20210714100445.hr73r2dfkxf36f35@haukka.localdomain>
References: <60e5ac8c.1c69fb81.c69f0.abab@mx.google.com>
 <20210708095425.13295-1-detegr@rbx.email>
 <20210713185311.200023ef@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210713185311.200023ef@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 13, 2021 at 06:53:11PM +0100, Jonathan Cameron wrote:
> So this sits on the boundary of whether it is a fix or not.
> Do we want this to go into rc1 + stable?

I'm not familiar enough with kernel development to give any opinions of
where this should go, but I would say this is a fix as the current code
won't work with certain hardware configurations.

> If so a fixes tag would be great.

This would mean a v3 patch with fixes tag included into the commit
message, right?

-- 
Antti
