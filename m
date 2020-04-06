Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9817F19FE5C
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 21:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgDFTrI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 15:47:08 -0400
Received: from mout.web.de ([212.227.17.12]:55577 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgDFTrI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 6 Apr 2020 15:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586202421;
        bh=bJ6wweKpkHlByA6Q6e8+/NUkCdi0x/x3PugEKawABUM=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=Xc0rOf/Yil9FKybcL/IBsC84ah9yskuJLyxnzOQkKeIiwZ1+BTk2G6vF24xvzZwMC
         HSYbUDPaVjGbPM7nqr/xeLyv0jImwaR7k9k+jwoNG3spZhWhJKwrLwjFCU/7zNu4fC
         0wMMAXWwpzC9vQZIYu0UYCOS9XSySNh5TvKu2RXg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.176.200]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LylnX-1jHOTr3m9X-0169ZZ; Mon, 06
 Apr 2020 21:47:01 +0200
Cc:     Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7192: fix null de-ref crash during probe
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4ff0776f-b5de-536a-ccf9-7516f1a65d87@web.de>
Date:   Mon, 6 Apr 2020 21:46:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nTkTxTA1SZNVGPWwxO9KOH6GehbIAhymhujo1VqWuIDAZu/B7nk
 MCk7vNIcjXdXG8m99Hf9+4rT8A2L1EIEgweTFPC/fvj3RZxkuvEN07wlV47ftwn4xOJLImZ
 bWF5ScRJc9+cKsTcXRENIhb0P/1IUoc+5eSKMXytIG83sfMQbd5FacDhU8qQGJDekFwlsx2
 2KGnEOgc1rc2MWYVhVYag==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QVlMxmMQ314=:T53pCEETDaqWsriQ+Vhxn0
 e6PTAp4Iqn7Qz+DDFavIHC3Jd2gjP9BBAeTvWu8o0OpqtlFYZXFDmnZaLEl2LtDn/fZbs7ux6
 YNBX1Qpo5tnPsMZCVKsBgJJtB+iv/muKrsTa3QgFQOr9vzfgZd44bDT/3lbeVXpWdZjYcAdRh
 74AP+xVM+oATPH+WlLDRJhnADqdjjAJsAAQz55x25/8WAMQWAaZDbf8DcOcc+gV2sAjbKEYmq
 fz+OGlfm5Kn0NIP1R9qWbOmsx727OO2TZacmRBJO4k6Jr8bKe86kmOZI2DnVYCUNr8OI/ctHe
 Zx+4bgi1Pmz6BBdPnRhO046Y8cVUaLTmPPT0xpJoJiAIC0Gqvo7SsJgnmhbiWZC6oxvulGcWr
 JQtT3adGy05tiSEfSFNokO/H58sypdrndbqKJg6upblYyYc2nnUWKEaS/ChFyLgjlOx1PsBe0
 d2rL149mh3U/eQHnlYNCjSipi9ci0wwv+8YHPq0X3i5nbsjJzm7/89Ds/shFKnEcoQNKEJYkJ
 +wqjaIjF9PiDfcuAsy0DDwVnRkqdo2OT7vdOH66BW7ncL6s6ksUA6NUOMQG8aD8oTAUthS204
 lTFtF5+fe2xlyEQzTCFSCOEWnahxZUVhNZTxiusDHb7AQYfhUmVKmVxC9jtmEyTp+e0VC0y5r
 Y6it3dHl5BXA/Kiwb4P1AsFCoSC0Gdp+UAN5eALfOaJvsVKHhTyghep92xL3PHhhJdj0b55/g
 EI3v2zSUyMQbrGUWLdfSKgKrYsYqm+vy0o5WYm4IPQSik1xoGBK0xNVAv0PshLXUiwDQjTwjy
 t+miPb/MJo2/x5QfSXVS8YTzImCmGFHfVW0EuQ0iRVJDiSxHMF7sKVaoI5Q67EZkLrGFKoZ8a
 GcgjyBkipctXisvvpK9fpQ9xLf9x5aUIdZwrgYAvK2WOEhrxSL0oX7l89svCduuDARgzmzqV7
 3Z6n1J0KRriP7kf/dc2CqFIzhVazAY7mmQWzl1Smeik6kMG5Qo6G03kxDY707kmK1UVVlq/Lm
 1ZuYUEMJtOBHQkSfo1T17HbtewV+Tg3saW3oyQYWjGAon0mdN06qexYPtIcS0uUx5KaK5EWiK
 4b1kyjmCdEobfG1nNfwD+M2tu8Vblj2tE51oGiWEa8QzYZM92/97QERGkRf2SjsXqIIWEhTJu
 fSkWy9+LhLdUm/BU1hLvN+QeGhXapRDGeJvWpq0VCh6f6L9MkkkSnnAWeEShJaeKJga0sR35O
 m8N5eKNhlv/YITcLu
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> After that patch 'spi_get_device_id(spi)' returns NULL, so this crashes
> during probe with null de-ref.

How do you think about to use the term =E2=80=9Cnull pointer dereference=
=E2=80=9D
in the commit message?


> Fixes 66614ab2be38: ("staging: iio: adc: ad7192: removed spi_device_id")

Please correct this tag.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D7e63420847ae5f1036e4f7c42f=
0b3282e73efbc2#n183

Why was a colon misplaced here?

Regards,
Markus
