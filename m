Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F92C182A5
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2019 01:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfEHXUC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 May 2019 19:20:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38085 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfEHXUC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 May 2019 19:20:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so235871pfo.5
        for <linux-iio@vger.kernel.org>; Wed, 08 May 2019 16:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zqe4t+t486G8cd+U/wB4LASYl9lt7sV86+xqjCXg3ho=;
        b=VvhMfXaOZUp/wbwAB7BO94QOlnQMYhoMCM1HOiATE6hpK0n9Ci79cY9uE9ie7+Zr2w
         hRSEtkMeRLuq9Lrd03ktR1Mft/qo1zQArSFEGmo4qxQHRqR8NZwVkKcs6AW5mrzJfpvp
         C97E7uMkrn0CI+y0r7WL5fu86hF2UD/n631XVVpuFpZ+9V3zKV/O/+DtQRf90adqvJYC
         rId9sW8etnmO8jQUIPR7L6ybatJQw6A/18F66WN3WliJmqg+R4YwmBPzleKXMHbqN2Hs
         p2Y9IxeVGYy/czkaiTizrT5aMLzJ4hAuZkPA0coyAw7dy7OJ5BBydGjuw+Y6bwwJbtpp
         JjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zqe4t+t486G8cd+U/wB4LASYl9lt7sV86+xqjCXg3ho=;
        b=i0zr+Ixfh0AcTM9LsvAcFqsc97PbgweWjFXH9URyyJ6SoptgtI33Ry2Y6zce9yFXTl
         IKHoaEL19Gz3P+vS+Sf2c5xWUk8wHaT8lbfUErVMRC6EisK7sdcX7CYSjnD+yYlG6YQk
         D8vrCL8HB/DEJDktAbenDhWCKj84sYOzRV02dIsvA7J2zrU6yneaXVPG5iozE6J3dn1A
         rPQ7mgfYL5mAxl4rZH7m3XEcVga1Bvn3nUbxgol+XvLupJMbdHdd0hPKAplh6Ny3LfDe
         IwcXEAuVP7dOc08Ap/xHda8pVmvKi3bSODtgYesOgwOvTZq4eQWUz00xFT+eFUwNm3WS
         E7nQ==
X-Gm-Message-State: APjAAAU5rYMFD+7b8C9TK+vbN+j9v1xSOKb/+Rqqy5OYw5xwKQGZsNjc
        5+8pss/szQjoeecwQ2rK5FvkiQ==
X-Google-Smtp-Source: APXvYqylCslQ4AXsRoEXwQnBh/Sno1seIsT1UKqTFUEurGVwoQWu4hQ7/dNzf23Xfcr/nyAsptGXuw==
X-Received: by 2002:aa7:92c4:: with SMTP id k4mr229105pfa.183.1557357599968;
        Wed, 08 May 2019 16:19:59 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id d5sm297224pgb.33.2019.05.08.16.19.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 16:19:58 -0700 (PDT)
Date:   Wed, 8 May 2019 16:19:54 -0700
From:   Benson Leung <bleung@google.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, broonie@kernel.org,
        cychiang@chromium.org, tiwai@suse.com, linux-iio@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 00/30] Update cros_ec_commands.h
Message-ID: <20190508231954.GA41543@google.com>
References: <20190503220233.64546-1-gwendal@chromium.org>
 <20190507094446.GD4529@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20190507094446.GD4529@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gwendal, Hi Lee,

On Tue, May 07, 2019 at 10:44:46AM +0100, Lee Jones wrote:
> On Fri, 03 May 2019, Gwendal Grignou wrote:
>=20
> > The interface between CrosEC embedded controller and the host,
> > described by cros_ec_commands.h, as diverged from what the embedded
> > controller really support.
> >=20
> > The source of thruth is at
> > https://chromium.googlesource.com/chromiumos/platform/ec/+/master/inclu=
de/ec_commands.h
> >=20
> > That include file is converted to remove ACPI and Embedded only code.
> >=20
> > From now on, cros_ec_commands.h will be automatically generated from
> > the file above, do not modify directly.
> >=20
> > Fell free to squash the commits below.
> >=20
> > Changes in v2:
> > - Move I2S changes at the end of the patchset, squashed with change in
> >   sound/soc/codecs/cros_ec_codec.c to match new interface.
> > - Add Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >=20
> > Gwendal Grignou (30):
> >   mfd: cros_ec: Update license term
> >   mfd: cros_ec: Zero BUILD_ macro
> >   mfd: cros_ec: set comments properly
> >   mfd: cros_ec: add ec_align macros
> >   mfd: cros_ec: Define commands as 4-digit UPPER CASE hex values
> >   mfd: cros_ec: use BIT macro
> >   mfd: cros_ec: Update ACPI interface definition
> >   mfd: cros_ec: move HDMI CEC API definition
> >   mfd: cros_ec: Remove zero-size structs
> >   mfd: cros_ec: Add Flash V2 commands API
> >   mfd: cros_ec: Add PWM_SET_DUTY API
> >   mfd: cros_ec: Add lightbar v2 API
> >   mfd: cros_ec: Expand hash API
> >   mfd: cros_ec: Add EC transport protocol v4
> >   mfd: cros_ec: Complete MEMS sensor API
> >   mfd: cros_ec: Fix event processing API
> >   mfd: cros_ec: Add fingerprint API
> >   mfd: cros_ec: Fix temperature API
> >   mfd: cros_ec: Complete Power and USB PD API
> >   mfd: cros_ec: Add API for keyboard testing
> >   mfd: cros_ec: Add Hibernate API
> >   mfd: cros_ec: Add Smart Battery Firmware update API
> >   mfd: cros_ec: Add I2C passthru protection API
> >   mfd: cros_ec: Add API for EC-EC communication
> >   mfd: cros_ec: Add API for Touchpad support
> >   mfd: cros_ec: Add API for Fingerprint support
> >   mfd: cros_ec: Add API for rwsig
> >   mfd: cros_ec: Add SKU ID and Secure storage API
> >   mfd: cros_ec: Add Management API entry points
> >   mfd: cros_ec: Update I2S API
> >=20
> >  include/linux/mfd/cros_ec_commands.h | 3735 +++++++++++++++++++++-----
> >  sound/soc/codecs/cros_ec_codec.c     |    8 +-
> >  2 files changed, 2997 insertions(+), 746 deletions(-)
>=20
> Again, it would be good to get 1 or 2 more Chromium Acks, given the
> extent of the changes.

I've gone ahead and looked through all 30 of the changes here. It looks goo=
d to me.

Acked-By: Benson Leung <bleung@chromium.org>

Thanks Gwendal.

Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlzTZBcACgkQHwn1ewov
5lhjUA/3fA/KxWw5Iys7vvzAAJjcfVmJy+xWem/JAjKjAe0kVJIX/t6badYGOTsI
KkdhoeXjrd+UDnhCQ3zAfRNz8UbAB0GFh1xOg7Tx9ooy2RiGHjcwyGvp1F+d9T9A
9LWavFRzNj+NECuV91pdMHi1VN7UOYoQj8o7f/LMIdsv2dfjfT7/grsYj3q3cjzX
gyi8a5QUb46vcmSSR+hh9KX/ymAjegSEPLWPBC7B237PHmdRSQ3W0C3M0V8ke7nB
gNH+7T8p9/ZzEfVSVydNogTpNDRiXpdEG1PIk5eXbRIr3C3Kv25JR76k5Ljkf6U8
zXdNMZUYFISYPqsqtp2YAbDrZh0Ok7M5I63Wf5SioUFI4bCEQUq0PZjM0//q3/RE
8+walobqHB/+zCLHwh8hqEmy/67J6b6Cww+1pO7l2YUa3ohit6xYTSzs+kGZ3MJ5
s0goLRIMvOvduBuRmW1JrJ57JQSypGL5idWnaX104t/1qHBllKs2w4O1jK1xx4tE
2XvTf/h/8Oq1k4/BYsmI3Tg+beXZogpNEmoXwzxDxE8PNlJ2aEJmZhdcnzT0ZCM8
fGutiblcNwe0JyceAgNrwhlTcVMIlu8tyyXLZBovccSMLBP3w/Fhw5bQbVN5YdRQ
kxXbzvKM6IqwtoqtcWwkKfMahw3ViEpJm41VSrwU5Esz3Ryk0w==
=O6+L
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
