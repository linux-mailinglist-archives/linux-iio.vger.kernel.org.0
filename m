Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B0A46C3B1
	for <lists+linux-iio@lfdr.de>; Tue,  7 Dec 2021 20:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbhLGTe0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Dec 2021 14:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbhLGTe0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Dec 2021 14:34:26 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421C7C061574
        for <linux-iio@vger.kernel.org>; Tue,  7 Dec 2021 11:30:55 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id z8so25898ljz.9
        for <linux-iio@vger.kernel.org>; Tue, 07 Dec 2021 11:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QKYilOdP7Yf7mqn/vZMcw/Iu8J+Ul6GWSBNFIKCT6CA=;
        b=SyZIJL4QrYXNhJqZ+3Pj9tY20aBtQLHnPCzyCGf7s+heb+IDZ9vJIdUZ8/hFpXF5Or
         irdJIU1/zKefBqAj2HvSJp1PM9lcoN9saFL+VzUZCn6qPgQ1WYE689EsziN2TVzWZukp
         y9R4idfCMjKMe3lOErG1hmiZZynCEEilF6sp9gdF0pFursXNZmi5EeIBPvRb5tG8hVNP
         fpD65SBn3zlQbIxtiWdi72zywheC1d5pCmFjvcGbEQd24ke7h7vDJNfqW9xrC4MJJwOf
         Gz+VTN0ihrnzaGhTH/TvNjQPdhCnHabFRDXftldIwNZ3tuTKrgwRlBDsHqW/PFRqLg9a
         9NNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QKYilOdP7Yf7mqn/vZMcw/Iu8J+Ul6GWSBNFIKCT6CA=;
        b=MsrmIrAsTXWy8U/Fpt03CSpsqnFShqICnfl/WoGQUWtNcYXDJpE+1Q8us0wbcGth46
         GhIJK68grf0fC9B5vNFNrQbKfdmdAEvrqyMKt/tqJ1qEc4v5Hn5LMrXrs90bpDWGBAth
         vvMNvs1mWgO7O3pXPEhVd3l+ovN2pnX/OCTDHwqCl+SQ1AUWTNa9ZiTaL+xykZma6XyW
         5wccsrRAl1ZL/Dl8pHFIRdGTNJgPlu7W4T4X/YjJiFneipEi18ebOU99N5rf8+dJDOha
         21F0mhG7lEo4vHVDJuCr8xIVybrQbN9QDGRL6XRbarcDF1ZlGPDrcwASQc8usbO4SZtF
         evnA==
X-Gm-Message-State: AOAM5315zKLfQhZxbAb4lONmatHBTx9TNZCOD2XNxGGEfRardx8K8Xsi
        x2Rp7zxm1HQ/b0pcoWfdHbYnUCsnb6w=
X-Google-Smtp-Source: ABdhPJyHKEsTcIGsV0eyu2e2vG2Uqty+hEtIBKgPptaM4gpisJ6f5enOLqJnuVP0nG9+k7xt2nFhEA==
X-Received: by 2002:a2e:a7c8:: with SMTP id x8mr44052216ljp.524.1638905453570;
        Tue, 07 Dec 2021 11:30:53 -0800 (PST)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id v7sm43511ljd.31.2021.12.07.11.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 11:30:52 -0800 (PST)
Date:   Tue, 7 Dec 2021 20:31:01 +0100
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kent Gustavsson <kent@minoris.se>
Subject: Re: [PATCH v3 08/12] iio:adc:mcp3911: Switch to generic firmware
 properties.
Message-ID: <Ya+2UABHGpgYv29y@gmail.com>
References: <20211205170140.2783914-1-jic23@kernel.org>
 <20211205170140.2783914-9-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZOfRchu6gDg2rPZ1"
Content-Disposition: inline
In-Reply-To: <20211205170140.2783914-9-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--ZOfRchu6gDg2rPZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 05, 2021 at 05:01:36PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> This allows use of the driver with other types of firmware such as ACPI
> PRP0001 based probing.
>=20
> Also part of a general attempt to remove direct use of of_ specific
> accessors from IIO.
>=20
> Added an include for mod_devicetable.h whilst here to cover the
> struct of_device_id definition.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>

--ZOfRchu6gDg2rPZ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmGvtnAACgkQiIBOb1ld
UjJCaxAAyOUBmpn1zA/cRvaz314o3cWtP6XWMXL7QuhFGVj+jrrDhvvR4FsZa4P7
KuPTPwy3BQYDIqcE5cQ64KlDBcjoX2HBdpeg8bv9NRdLyO+3PimGc5vDq1QHcf3I
/xm6YMztnOPLaRrGWDeLHfVunZ6JowKG4iAK4EodOZg3exXQmM+dlHTO2BL9oe09
hPGC+/OoY9HE37hVsILPdQgOHQfQXyZ6Ih2AQWBN4C/qMyaa5lrKCOYsave+JuVa
JFa0NTmpucFiHuwRt6GIRLDKBYgvsFfWquKUFDdKfAZSnloznqZLM1aheFwt/Hqo
lrZ5GtVll4C2HrMQmQgr2+brsQ7Zg0NM1+s2DdB52n0xl9S4rhKmZ9YQUWUC0UEG
8NbuJ7NFSDq7fXr7bAiE1nlx1ei9cfpxY75HYDTEWtFuBylcyiiZ1RBm5k1+cjyl
Y4lJ8C4tKj4KcMikZgnQoYcRKnS2+f0+n/BaaMfWYt0B+v4EQ63MkDh7gJhrYpvs
HZW9Mpn+MAlzku3h9VdJtKOYPMcHN534SHLX1t7CTnN1Ada8EADH4g45ONLTZHVA
7A04WSZ6lBo8xpCX1SI82pqZZPaalocLWbBwnGBtfey8/ZuJ4jgBaQN9EDqjFvlG
T/095og0oA+LsVQK0Kx2RCOYFg69LvlzDG3Rfm2MTBH41glP2Eo=
=nOep
-----END PGP SIGNATURE-----

--ZOfRchu6gDg2rPZ1--
