Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98B3D18E9F6
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 17:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgCVQBZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 12:01:25 -0400
Received: from mx-out2.startmail.com ([145.131.90.155]:57586 "EHLO
        mx-out2.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgCVQBZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 12:01:25 -0400
Date:   Sun, 22 Mar 2020 18:06:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1584892883;
        bh=tw0ThCWI6Kf/ThW1nb3APK71N9og+oAkYn4EacBWeMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U6XcNeoSW3y31P1NSwUv664upochH/VhOGSeIZvsaGD/43e5v285IK1r0wstqbLWM
         GNFGh5XA0EQLDNRBvy0JVJc4y2koeCCYKOkQDPJJ/SqO/0euqpQHETeIwwMm9YovX3
         u0IGDw7Ea2nWOtvnwhMg28YMnaqKirLIn1M8aHsBtWHeXkGvNV4TfiKuMwlZ6cAlej
         lW+2DVzCwqyvIBMj9Nrbdo/8TQSx+pIWmkcjb8+UFic7ybqLDJb7qAjoOt+D6vtRMD
         OsaTx3qfRRZj7Tuwf45P7MnaupD2PjQXvdXnQnhXXPsUHaooV1RRe0ntzDQSGLTNTb
         Wb9FS/eVlIz5g==
From:   Alexandru Lazar <alazar@startmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: Add MAX1241 device tree
 bindings in documentation
Message-ID: <20200322160604.GA222611@leena.republic>
References: <20200320150114.9297-1-alazar@startmail.com>
 <20200320150114.9297-2-alazar@startmail.com>
 <20200321173412.52548ef1@archlinux>
 <20200321193541.GA16892@leena.republic>
 <1e51c4079222858410e9fe94c9d7f21d99abfe15.camel@analog.com>
 <20200322095317.GA3099@leena.republic>
 <20200322152735.36cb3493@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200322152735.36cb3493@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> You'd be surprised how often this gets added to drivers precisely because
> people will put it on a controllable supply.  It may well not have it's own
> supply but it may share one with a bunch of other external chips and
> all of them need to use the regulator framework controls to make sure it's
> only disabled when they are all suspended etc.

I figured it might be something like this :-). I've added the vdd-supply
binding in v5.

If this isn't something that can be easily handled in the core, do you
think we can document it somewhere as a convention/common idiom?
(Assuming it's not already documented, of course). It seems like it's
something that all IIO devices would need. I can do the writing part.

Thanks,
Alex
