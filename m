Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05ACB1708E7
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2020 20:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgBZT1f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Feb 2020 14:27:35 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:51790 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgBZT1f (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Feb 2020 14:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0GMgWUbqUzIsyE6UgLwb/MaJmJqh4t9npOvnI6kW9zM=; b=mZNw0wYxd0Cqx7/VZU5/nVtul
        EDFoAbXlz8d0Lgyhahw4MO/o1l6itibTjxWk9T6kCGcI+gSDBDyCwXBhdC8ISWhC5IhOokeeY5Oz6
        G/qJ0kcOL4IYqCYRwJCwgG4G4ohPYu58OrSZU5tmruwuxLP1OWpI7trKviEZ/e6aTthek=;
Received: from p200300ccff0a4d00e2cec3fffe93fc31.dip0.t-ipconnect.de ([2003:cc:ff0a:4d00:e2ce:c3ff:fe93:fc31] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1j72LA-00081x-Ag; Wed, 26 Feb 2020 20:27:28 +0100
Received: from localhost ([::1])
        by localhost with esmtp (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1j72L9-0001iu-Jj; Wed, 26 Feb 2020 20:27:27 +0100
Date:   Wed, 26 Feb 2020 20:27:19 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, b.galvani@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, phh@phh.me, stefan@agner.ch,
        letux-kernel@openphoenux.org, jic23@kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 2/2] iio: adc: rn5t618: Add ADC driver for
 RN5T618/RC5T619
Message-ID: <20200226202719.46ce9600@kemnade.info>
In-Reply-To: <20200223131638.12130-3-andreas@kemnade.info>
References: <20200223131638.12130-1-andreas@kemnade.info>
        <20200223131638.12130-3-andreas@kemnade.info>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EmIe0/b1v4/JZB0O9CA8Hso"; protocol="application/pgp-signature"
X-Spam-Score: -1.0 (-)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--Sig_/EmIe0/b1v4/JZB0O9CA8Hso
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, 23 Feb 2020 14:16:38 +0100
Andreas Kemnade <andreas@kemnade.info> wrote:


> +	if (rn5t618->irq_data)
> +		adc->irq =3D regmap_irq_get_virq(rn5t618->irq_data,
> +					       RN5T618_IRQ_ADC);
> +
RN5T618_IRQ_ADC is defined in the RTC patchset mentioned as dependency,
which adds IRQ support and I am asked to rebase it on top of plain mainline.
Does that mean that the kernel git source does not need to be bisectable
anymore?


Regards,
Andreas

--Sig_/EmIe0/b1v4/JZB0O9CA8Hso
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl5WxpcACgkQl4jFM1s/
ye+72BAAtngnAhkbZ3h2LxZObD2b5dEtNpqJf/t+DgVyTkAqIjPg0wl9gs8sErW7
9tuqCkUsrGgp2CYh1bYIep2EPJR39LMu2eCin9+B4x2Kx2zB2uMV2CVKmqZlDo63
8zu07unuMCv1f37MojobdmiEOmMexLKM7ol5NmA/oNkB9LfG80seNZpDRQv+oOQu
ESvMWbNoWUvGuXiejpTRDGnmHZzKKUb87JV4+ki/dKCaVA4uMswLWQ0m9ipDLJxV
uVrs+DvjOWbQYBDpqLoEyxre7c0Ln5R6lOYk0DoYqihIMamvgLqJJ71UMHIqKnl5
CPmVcwoYm1YG6kCU47EwuRtAg9qwFKN9+Ch5ApEgvQnBjrjZWKkk9lTsdBmAOkWQ
j3cDnA/4UbJ10X7J8U5JPaZXQkgR7/dXLlzXqojIatRza1LTIIGTCcOw/IL2ic12
nunrbYMC9cIL+k/u+e/NSCMmUWGE8lGeoUioxUikNCzPUkW/y73UWFUVeWhn8SX8
tuoXhEvUWI1gpn2OC9sRFWqEkOFDeWYGbVhtJxW9lOFrspyq3TQ+/bYlxmpClWcf
82Zg4zKFAIVOiCNKmxlgPYt+cgTrpegdV/9ZJWdhLUo+AnYHs6F5ZUu83LqCq4td
F3SvugDza3cOydyP7YSN8Czebmg1e5/hRCrpPMyfJBaG3u7kJ1c=
=Erno
-----END PGP SIGNATURE-----

--Sig_/EmIe0/b1v4/JZB0O9CA8Hso--
