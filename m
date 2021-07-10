Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6F53C33FE
	for <lists+linux-iio@lfdr.de>; Sat, 10 Jul 2021 11:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhGJJo0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Jul 2021 05:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhGJJoZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Jul 2021 05:44:25 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA7AC0613DD;
        Sat, 10 Jul 2021 02:41:41 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id j3so4412951plx.7;
        Sat, 10 Jul 2021 02:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dOuGwi5g8KH8o/3jSO3jWheg70j5XLxqo8vJddb42OE=;
        b=ZiQThSmAl/ZECAxgnmSL4xy6k4X/WFU5EH0cAfs75LVlKEZjyJhGj2oCr2sDym/B5d
         q5Gub2WtHuAlUH2AdW7vP/201i/ggpEfbsMCFtMqucypEPwrkK4jA66Ptz2E6VIN3TTu
         UXFviDw2EdxxJkY3c8Zn/mU1S0HmSROgfaO+1knX/UCBKVPVPmWigmp/Vl7IL9+8w48w
         It86y1pwjB/Si/ZaUqNADXaaOGh2/4nQzJVNgT2VCy15rddx+3AxpFFgQFEeCYiR0NQt
         Q8rBbEQc9xvVLkCfpGvIxesSinfSqCG8FGRNNszsOXJLutDpk0JlcjfkDLq7n9HJrkT5
         nK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dOuGwi5g8KH8o/3jSO3jWheg70j5XLxqo8vJddb42OE=;
        b=DFz597ySSeQNVauoAZHKses05Vnu7lxUZwH4mbbEI3vGIJAr/OW5sHw2tPZqJTnO42
         jiN7K/nL3FSoGyhKnEzBMZIkW2o1v8pR//lDQzw6+nLWTXLCWn4Qhcbv4Ob4FEuKuVnu
         xfKzMdI2P+aPI5zotKXghPMWbUe6m0VmiT7MPt2ItfcQLONri8i7FtZQonSzPlq5fBtL
         jF2XLDfRFYO4kUukIZOqE74TQAI7eJ/wmUpNQc3078Xhi4gNVoQUVLBmEIluxTv3XgFA
         NlURwrj29XdJ6ZZyXCp33h6gAUsUNEKRyacPPPOurQ+oY9GCdBXBqMHgoG1DylU9Nlo9
         3txA==
X-Gm-Message-State: AOAM5338yqVBj8r/zz32SucHg1XQa2YUTnQcOXWOeh47JE2a+sPACSAM
        gVkG0IlMrQL19VC8dv7BEk8=
X-Google-Smtp-Source: ABdhPJw8uRxWT8wVhoOu6303vn36tvXq7yLoZJHoQJPDynFxP8wsH8NApOu/nYKRmKLKyXLhDZ1d4g==
X-Received: by 2002:a17:90b:164c:: with SMTP id il12mr41735907pjb.44.1625910100443;
        Sat, 10 Jul 2021 02:41:40 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id b13sm7073039pgk.66.2021.07.10.02.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 02:41:39 -0700 (PDT)
Date:   Sat, 10 Jul 2021 18:41:27 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     jic23@kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        kernel@pengutronix.de, a.fatoum@pengutronix.de,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com
Subject: Re: [PATCH v12 07/17] counter: Update counter.h comments to reflect
 sysfs internalization
Message-ID: <YOlrR6cbcKjok40e@shinobu>
References: <cover.1625471640.git.vilhelm.gray@gmail.com>
 <4223302f61b77b82b3927bd3280d0df791418d76.1625471640.git.vilhelm.gray@gmail.com>
 <caba5d29-0820-0821-50ba-260933a2ee5a@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4J7CaG0qhpUbAVj3"
Content-Disposition: inline
In-Reply-To: <caba5d29-0820-0821-50ba-260933a2ee5a@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--4J7CaG0qhpUbAVj3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 09, 2021 at 12:49:20PM -0500, David Lechner wrote:
> On 7/5/21 3:18 AM, William Breathitt Gray wrote:
> > The Counter subsystem architecture and driver implementations have
> > changed in order to handle Counter sysfs interactions in a more
> > consistent way. This patch updates the Generic Counter interface
> > header file comments to reflect the changes.
> >=20
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> >   drivers/counter/counter-core.c |  3 +++
> >   include/linux/counter.h        | 43 ++++++++++++++++------------------
> >   2 files changed, 23 insertions(+), 23 deletions(-)
> >=20
> > diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-c=
ore.c
> > index 15f735ef296e..9442e3b91468 100644
> > --- a/drivers/counter/counter-core.c
> > +++ b/drivers/counter/counter-core.c
> > @@ -41,6 +41,9 @@ static struct bus_type counter_bus_type =3D {
> >    * This function registers a Counter to the system. A sysfs "counter"=
 directory
> >    * will be created and populated with sysfs attributes correlating wi=
th the
> >    * Counter Signals, Synapses, and Counts respectively.
> > + *
> > + * RETURNS:
> > + * 0 on success, negative error number on failure.
> >    */
> >   int counter_register(struct counter_device *const counter)
> >   {
> > diff --git a/include/linux/counter.h b/include/linux/counter.h
> > index b69277f5c4c5..e7fd6d81a929 100644
> > --- a/include/linux/counter.h
> > +++ b/include/linux/counter.h
> > @@ -188,11 +188,10 @@ struct counter_comp {
> >  =20
> >   /**
> >    * struct counter_signal - Counter Signal node
> > - * @id:		unique ID used to identify signal
> > - * @name:	device-specific Signal name; ideally, this should match the =
name
> > - *		as it appears in the datasheet documentation
> > - * @ext:	optional array of Counter Signal extensions
> > - * @num_ext:	number of Counter Signal extensions specified in @ext
> > + * @id:		unique ID used to identify the Signal
> > + * @name:	device-specific Signal name
> > + * @ext:	optional array of Signal extensions
> > + * @num_ext:	number of Signal extensions specified in @ext
> >    */
> >   struct counter_signal {
> >   	int id;
> > @@ -206,7 +205,7 @@ struct counter_signal {
> >    * struct counter_synapse - Counter Synapse node
> >    * @actions_list:	array of available action modes
> >    * @num_actions:	number of action modes specified in @actions_list
> > - * @signal:		pointer to associated signal
> > + * @signal:		pointer to the associated Signal
> >    */
> >   struct counter_synapse {
> >   	const enum counter_synapse_action *actions_list;
> > @@ -217,15 +216,14 @@ struct counter_synapse {
> >  =20
> >   /**
> >    * struct counter_count - Counter Count node
> > - * @id:			unique ID used to identify Count
> > - * @name:		device-specific Count name; ideally, this should match
> > - *			the name as it appears in the datasheet documentation
> > - * @functions_list:	array available function modes
> > + * @id:			unique ID used to identify the Count
> > + * @name:		device-specific Count name
> > + * @functions_list:	array of available function modes
> >    * @num_functions:	number of function modes specified in @functions_l=
ist
> > - * @synapses:		array of synapses for initialization
> > - * @num_synapses:	number of synapses specified in @synapses
> > - * @ext:		optional array of Counter Count extensions
> > - * @num_ext:		number of Counter Count extensions specified in @ext
> > + * @synapses:		array of Synapses for initialization
> > + * @num_synapses:	number of Synapses specified in @synapses
> > + * @ext:		optional array of Count extensions
> > + * @num_ext:		number of Count extensions specified in @ext
> >    */
> >   struct counter_count {
> >   	int id;
> > @@ -243,15 +241,14 @@ struct counter_count {
> >  =20
> >   /**
> >    * struct counter_ops - Callbacks from driver
> > - * @signal_read:	optional read callback for Signal attribute. The read
> > - *			level of the respective Signal should be passed back via
> > - *			the level parameter.
> > - * @count_read:		optional read callback for Count attribute. The read
> > - *			value of the respective Count should be passed back via
> > - *			the val parameter.
>=20
> Are these no longer optional? If they really are optional, it would be ni=
ce to
> keep that information in the description.

I'd expect drivers to have at least the count_read() and function_read()
callbacks defined and set; otherwise such a counter driver would be
rather useless to a user. I'll update the documentation here to make it
clear the other callbacks are optional.

> > - * @count_write:	optional write callback for Count attribute. The write
> > - *			value for the respective Count is passed in via the val
> > + * @signal_read:	read callback for Signals. The read level of the
> > + *			respective Signal should be passed back via the level
> > + *			parameter.
> > + * @count_read:		read callback for Counts. The read value of the
> > + *			respective Count should be passed back via the value
> >    *			parameter.
> > + * @count_write:	write callback for Counts. The write value for the
> > + *			respective Count is passed in via the value parameter.
> >    * @function_read:	read callback the Count function modes. The read
> >    *			function mode of the respective Count should be passed
> >    *			back via the function parameter.
> > @@ -291,7 +288,7 @@ struct counter_ops {
> >  =20
> >   /**
> >    * struct counter_device - Counter data structure
> > - * @name:		name of the device as it appears in the datasheet
> > + * @name:		name of the device
>=20
> Is there a recommended naming convention if using the datasheet is no lon=
ger
> recommended?

I decided to remove the "as it appears in the datasheet" phrase because
there may be cases where the datasheet name isn't the best name to
provide for the counter device. For example, with the 104-quad-8 driver
there is ambiguity about whether it's more useful for the name to be
"104-QUAD-8" to match the PC104 card, or "LS7266R1" to match the counter
chip integrated on the 104-QUAD-8 card. Another example would be the
recent interrupt-cnt driver which isn't for a particular device (it
counts any interrupt source) so thus does not have a corresponding
datasheet. I figure it's best to leave it up to the driver maintainer to
choose an apt name that will make sense for the users.

William Breathitt Gray

--4J7CaG0qhpUbAVj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmDpazUACgkQhvpINdm7
VJIycg/8CJmeaBJQXPKQQXTqiiyWndTHp8WwIMji6oVyrvWoJyPBJ7iHaw/Ye0Np
+2HBipMQnwGEI27VcxT/XyrH8dGUQV7zL200Y5i0+k36JfldX/8ARIK+H05BiLBt
yCwDTLmCs/aiMR0vcRV+ZOAk0EK9z5GoIcTQpo6hcJuPGJRxzNC/7rCTFjb11HPU
kFREjrnVq9rhTOE2nNzMlpe51zFq5CcitydU83PJPT0+10oF+nzU5mn1SDPIw0Ps
oq9v5gUbzkDgU+bHbbW16DKnC3T8l/R0HJUXO/qJ08QW2AEvDWp20pCSGZ/tevh3
VuzOZipDpJc5djEzj7vFf66ta1NyR9D/ZsYkg74iIMHRMO6uqynWbK5LWDPtsY+s
jCoeRp05DB9+wI+rhAFwUBDfUaQVyWvxHz/A+UGJT2iPtC60Xb4E6uUu/DVbKVHq
QjAh1C6bsGj440nAJkxxX5fXNk4l6arI3vsyMayWQDjsdXZQsgROwqO43oXY0Jgr
FeHCrVAh5k9uqlXiWaE2tVX9NGJjoMYPzvTbARuBY02w+UjE3Cqz2G7V60AZs3IQ
uRs0w5eOAQNAmcNgMwviEUnVb3detoTjgOG9S9jWmvfDVi/vdjfstFKBw508PPsW
G5zkF14r3/U8PFKRCfEk8hdKpLdeyuRHP3V+rEJYrFAH1FGW1tE=
=+HKs
-----END PGP SIGNATURE-----

--4J7CaG0qhpUbAVj3--
