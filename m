Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEAEFAC5F1
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2019 11:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfIGJq7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 7 Sep 2019 05:46:59 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:38913 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfIGJq7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Sep 2019 05:46:59 -0400
Received: from localhost ([46.78.15.232]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M2wXK-1i9p5R3DKO-003Ibn; Sat, 07 Sep 2019 11:46:33 +0200
Date:   Sat, 7 Sep 2019 11:46:32 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     =?utf-8?Q?Zbyn=C4=9Bk?= Kocur <zbynek.kocur@fel.cvut.cz>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: srf04: fix wrong limitation in distance measuring
Message-ID: <20190907094632.kalkqtkxlfphdx4w@arbad>
References: <20190623122909.hhzskp6k5vm4wify@arbad>
 <20190626192134.4b7aed3c@archlinux>
 <03D5EE82-D6C7-4A03-9404-45B48F1EF5B6@fel.cvut.cz>
 <20190626204936.2756cefd@archlinux>
 <3372AFA8-5AD0-4044-9718-D3E2B76EDFAE@fel.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <3372AFA8-5AD0-4044-9718-D3E2B76EDFAE@fel.cvut.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:Vwb8KciSLxhKSWb4+LOIT7W6H+CBl46mJEgKl9Vw4M6FCC4O4Db
 0JoqCM/g4Zkvyo0Sf6IcVT24B/Kwnw1+DxzWFcwpzFbzxd02lr4ITpcI0MwK+m3qNLqaiic
 zsSalDk5wqvJY4iHPnyoCtXxK6X9HLxZiQNBXWjuxAG3iSHpa99TyJ9aD7itHGQK+dAxrLs
 gyR4fshxJcCgXtic6i1Og==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mmy+PEmkqsE=:JEcLnvaEhUWIvc0y9znaOg
 B1u+D8Ax7zlxbKiDgif4f2fHngn/FwdR/VVCrCO7OO7B3dVjUYKG4rTGbWl7deQht9iuVzemx
 lc4Iyqt9X9s878kRvSraA55tdldml0+DOxepKdvuN1nkFdVUwMUkvIT/4K+EXRkP/ej8cpf1d
 xXIXrzu3CUJ6RtrM0memfcCR7CMQ9Qh7x4s6tmnrWAiq0+b6bKIo6xcy14Obht/RlARlkweTI
 C5BMpFq0itUrENi3znes4RdR9xl2SJm+XlaRfG6l/35B8261PKugEryIkx0UziLP4b7vux3I4
 1B902z+A8oGBkrQYnz5XDdAV6sk6x29ojbf6Q46ponmFOMXfvBxcr9e+DliAX+mrHql0czWfx
 tThzDU4oT8siPjdjzK7Z/ldX3e/fGi/T7oTCjMltfKuLoO+Mh76YKuIDedmLVa0laA04Wmgs6
 O729wL49tOsWL7xzQoEvasEMvRMTWrfNaJ1kjq/xzCwPrgHUMvMXfHIvyAvNN//AT02SVXmDw
 y28it3CUybd+ZSBK+Zbgx0I/4MmjSADhAhbA1LwTrvcy8oJotmXBgHCGxC/Ammp+MwQ+S5ZU3
 5dreRWoenk74VQ4KiQtqj+o8f7CWtxYFY/GC8lYO6EzibrbT/x8VOzlbP/V8QPCyusL31McTM
 p5c0XEFAQ8bqzAPp3//V5vtrFtk9BcHBVgERcyBN54pdHfPvmt4GtIut6xoAfxQ672fTE+wUO
 SmLCCQqjx98qjOZXLzJh9tXEAR9HdqR03GvTTb/btNzgvlhvCccRwW4wu5SHY0/MU0WjnkrX2
 I8iQnPgNaf4ftM2ytS9qXhLTqpfhyUVrtJlebagARZsWsbiPT0=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Zbynek,

do you have any feedback for us?

Thank you,

Andreas


Zbyněk Kocur <zbynek.kocur@fel.cvut.cz> schrieb am Mi, 26. Jun 21:50:
> Thank you, i will write a feedback after testing.
> 
> 
> Zbynek
> ---
> email: zbynek.kocur@fel.cvut.cz
> phone: +420 224 354 054
> web: http://www.fel.cvut.cz
> Department of Telecommunications Engineering
> Faculty of Electrical Engineering
> 
> > On 26 Jun 2019, at 21:49, Jonathan Cameron <jic23@kernel.org> wrote:
> > 
> > No rush, it's a clear fix anyway so we can queue this up
> > in the rc phase of the next kernel cycle!
> 

-- 
Andreas Klinger
Grabenreith 27
84508 Burgkirchen
+49 8623 919966
ak@it-klinger.de
www.it-klinger.de
www.grabenreith.de
