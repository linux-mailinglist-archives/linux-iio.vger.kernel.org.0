Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C470A1E4E2A
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 21:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgE0Taz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 May 2020 15:30:55 -0400
Received: from mout.web.de ([217.72.192.78]:49687 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgE0Taz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 27 May 2020 15:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590607835;
        bh=EXR2BiKOTwaciW/Mys75uSRQDsAkHJB0uiphyQGosvY=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=GcPehbpdOkHrpBT6VXF3UDmN8KOSe8oePZm9kkiAcXPKX1OC3u4tV9yZOzG/tdFuU
         5ZayVsoMpMMfMyBoAbtZBkOIp3EqwJTI1RZDS04xLnfENlO19Zi9r0F4u3m0CuQXIW
         85UZyDH5LUgdleRoonKuZ8Zx3Y17Ww+XQDodWPKA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.185.253]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MiuSs-1j7yBz2YTM-00elQk; Wed, 27
 May 2020 21:30:35 +0200
Cc:     linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: amplifiers: ad8366: Add the missed check for
 devm_gpiod_get()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Chuhong Yuan <hslester96@gmail.com>, linux-iio@vger.kernel.org
Message-ID: <2b4d43a9-30db-95a3-1aa9-9efb278fd7f7@web.de>
Date:   Wed, 27 May 2020 21:30:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Do2W5RKgJEWiL6ta9m/xDuyNGeBLR6rKQvvf8xicOMbSOgw2e9e
 be8ru+be5rwqvC3GNcveACYSECtNOEXgZkkO6fpOVR5XW0V3Uj17gBQxhw2fSZsseptNkMi
 Isi+ZePbwmLiVyOqCSLotrc6+ppPjUari2606BgOw91lftgTL4smqUCWhYa7orwf6IPGy7C
 TqM9Q88o5izVDfjxvsmEQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NSug1gAueNs=:tdpMi7t4iV3NazBmdxhWKp
 SXAX18Qci5OoPjBVPLT2cnig/FXKQ9+D5CiAYZl+pmOhmbFctvPZLDSh2WU2zH8evjaFcJtmX
 b8E+1EI/oZZrBigzc70UFWNMbP/JSao2DkutNffyBcLC5WXHmQ0aNCJaz25UGVcFwJcCSKBsf
 rlaO7gXSu136Ve3q/bqzXtee3DONHe6lEAGUviI/JrISo8QZ4acs+LBDD7Rmn+bOUIdLVsENz
 wOX4peleocGlgWp95HyFPmi7qDDZTxj6G9cmEpcB0G7nCMeY1R19zsYsco/hYSXWNmSuJ5cwv
 LRshIxXVIwAR3H7dDRpUW8NhjMiL10LEHD2PZigW8xWUJLnxsqLn8CzRXVve8owOSfSkNJK58
 5/SxPMWU8NhVe9gdRbjsuO5r+TPsdMxp+O5ASLGcXOlFXAzuhSj8Dlu/WNyG8zeotGLZizFZm
 MCuwjed0lUQiBKjBL1giCtsQFLI9yuwEza8M5j6FikqE5JQY3qowzv0C+Ly1tvuOSPqxIpmwr
 qkUYl4RxUN+prNYGHZydaMdFRIYwOPDuvjeVj5bVvxxWNW2XgKmI62qTd2NOWhM2+GLw3QsSk
 WhSHDbCIq28mC7lssCY6pykhlZskwBnC/wsvpS7/sMHpXQIiWhFtjiyHLYLuAN6DyD7eStt/y
 LSY1zqtrlPHGQvJoqnsEy1bZVnSTXP5tFhv89IvLd0ynQt4JyUJZTfik2uUT/fqB3pVJaZ/wr
 XTPgpjyYKxT61bpnqdYmbkCHNRLszJGoSTUVWYcfZPtNUtyXmEnMGTTtw/HZlmlI+Yei2+33X
 sMxqyiYlvEXOqQ6j4DSVaQLB9ozLzG1HpGouO4MEhbwt5oxMmW3g1P4G8D/dbahVNSBYM4aBd
 LI2ThLdGaE8a3r/s35MiX0HjCfqCgRe7iZyJJJnNpE1cCDLJLux2ItFJpxcnHqidiHWINnE/u
 CQc9AJofyCTXc5EC4vXhEy6fpE5BJSSmrZYT0yQcAZKJR9+L7QnkB5NgsXTmvFuygbQEtVgXr
 qreR/lykLjjeue4J1qm4Uc38cz3MJiG93esZ+pgAj8ChYGvz9lLGlRlGKw/hoRIy8c5jM0m0d
 hoC5x3gOegZZQw4EYakCMuYTBFMbiEvRznTmFV9rBCgmvN6dUcg5O9NtQonigb3JwyBH19qUs
 qfyWI8ACUY1dThV0SHgOoqtWxVo5cR+l1caI77p9xBAkyps21WO8iRbSSNssFYdFIAa7bPlBm
 eJfFc0X5KsUXbFfaZ
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> ad8366_probe() forgets to check the return value of devm_gpiod_get().
> Add the missed check

Thanks for another completion of the exception handling.


>                      to fix it.

I suggest to replace this wording by the tag =E2=80=9CFixes=E2=80=9D for t=
he commit message.

Regards,
Markus
