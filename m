Return-Path: <linux-iio+bounces-14454-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D67C2A15DC9
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 16:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99BE27A2A28
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 15:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CDB19D08F;
	Sat, 18 Jan 2025 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hnox3wuZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952B618FDC2;
	Sat, 18 Jan 2025 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737215521; cv=none; b=qeOk8IPiRPs66k2HYnIzG2GfdIJCscmK99gjukFVXSFDGLKUsCbWwW9ebDqLKPOPpQ/wn4Chvn5W4gupKBH3Efe+FIqQWfNg/QH1e2Ig1gxY4hIwXQy5IZMZGvB5tuCgPORpdp2HIDtVY0My6vxIx3jmswX1qc9YNST9d3WmaTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737215521; c=relaxed/simple;
	bh=LuCN0ei6SeoYTqrIU3Whfac2+mdEiGh+s2UwggqjRo8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FoXP9PcT/JV14V5wlDzkflt35RiiYUqxJQp5X1rQ454PKS4nbPBwgED3NjeiM8efbYuF07T1d7r7AIU+P4Tz0P4kUg083sOHgnYNomwqJJmX6q+stw0ZBB5DlPyMZ6vRxoa5zR/mNwI4S9oByRgP/TGm8moMXrVPmouYsj5xTZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hnox3wuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00D7C4CED1;
	Sat, 18 Jan 2025 15:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737215521;
	bh=LuCN0ei6SeoYTqrIU3Whfac2+mdEiGh+s2UwggqjRo8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hnox3wuZev4syyzPhQR03rhMD8IpG06RCzi3CKA/eJot53xiCz60GSRqCW+7z49Jj
	 8LSKuBUHyoNzZtd8JANrcUOE1z0lf0Dzpc40AJMh2AV9+cZOc+PZq1nuiEiKXemdhi
	 rBLAOBxgEhbdI/ogh9Tgak/yOycHNrf/yi6AcO6yFgg7wuc/AWIakyCn+uHTy3rPKU
	 0tYvYSNfj52VNueMiQFxebnp9uSKm58TGM1bkNrA5tg4ok9ZU/pMACWztQI+rccBVK
	 0w5x413GNY0oLzli8f/2dMMm7gvKjxpVCKIGBVg1dmgBByBt0LENB74jcZ/23aarXy
	 eXinPZugBJWNg==
Date: Sat, 18 Jan 2025 15:51:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 corbet@lwn.net, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 1/1] Documentation: iio: Add ADC documentation
Message-ID: <20250118155153.2574dbe5@jic23-huawei>
In-Reply-To: <3bd58574-36c6-4102-ad7d-1aeff0e46a95@baylibre.com>
References: <efa1dba23c38b207716883d6226ce9e9df5a51b8.1736862045.git.marcelo.schmitt@analog.com>
	<3bd58574-36c6-4102-ad7d-1aeff0e46a95@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Jan 2025 11:23:24 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 1/14/25 7:53 AM, Marcelo Schmitt wrote:
> > ADCs can have different input configurations such that developers can g=
et
> > confused when trying to model some of them into IIO channels.
> >=20
> > For example, some differential ADCs can have their channels configured =
as
> > pseudo-differential channels. In that configuration, only one input
> > connects to the signal of interest as opposed to using two inputs of a
> > differential input configuration. Datasheets sometimes also refer to
> > pseudo-differential inputs as single-ended inputs even though they have
> > distinct physical configuration and measurement procedure. There has be=
en
> > some previous discussion in the mailing list about pseudo-differential =
and
> > single-ended channels [1].
> >=20
> > Documenting the many possible ADC channel configurations should provide=
 two
> > benefits:
> > A) Consolidate the knowledge from [2] and from [1], and hopefully reduce
> > the reviewing time of forthcoming ADC drivers.
> > B) Help Linux developers figure out quicker how to better support
> > differential ADCs, specially those that can have channels configured as
> > pseudo-differential inputs.
> >=20
> > Add documentation about common ADC characteristics and IIO support for =
them.
> >=20
> > [1]: https://lore.kernel.org/linux-iio/0fef36f8-a7db-40cc-86bd-9449cb4a=
b46e@gmail.com/
> > [2]: https://www.analog.com/en/resources/technical-articles/sar-adc-inp=
ut-types.html.
> >=20
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> > Change log v1 -> v2
> > - Split apart from AD4170 patch set.
> > - Added disclaimer paragraph about complex ADCs.
> > - Made the input type general description a bit more general, by adding
> >   `general` to the text.
> > - Changed `::` placement to be consistet in all sections.
> > - Improved Differential channels section with more precise explanation.
> > - Improved Differential Unipolar Channels section with comment about co=
mmon
> >   mode voltage being described in dt as a voltage regulator.
> > - Removed -VREF from Pseudo-differential Unipolar diagram.
> > - Added comment about omitting `_offset` when IN- is at GND.
> > - Improved .rst formating with ``.
> >=20
> > Link to v1: https://lore.kernel.org/linux-iio/48876e204590c47c532fc5f71=
e02ca3a00028cb7.1734530280.git.marcelo.schmitt@analog.com/
> >=20
> >=20
> >  Documentation/iio/iio_adc.rst | 290 ++++++++++++++++++++++++++++++++++
> >  Documentation/iio/index.rst   |   1 +
> >  2 files changed, 291 insertions(+)
> >  create mode 100644 Documentation/iio/iio_adc.rst
> >=20
> > diff --git a/Documentation/iio/iio_adc.rst b/Documentation/iio/iio_adc.=
rst
> > new file mode 100644
> > index 000000000000..b9d30e732a61
> > --- /dev/null
> > +++ b/Documentation/iio/iio_adc.rst
> > @@ -0,0 +1,290 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +IIO Abstractions for ADCs
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +
> > +1. Overview
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The IIO subsystem supports many Analog to Digital Converters (ADCs). S=
ome ADCs
> > +have features and characteristics that are supported in specific ways =
by IIO
> > +device drivers. This documentation describes common ADC features and e=
xplains
> > +how they are (should be?) supported by the IIO subsystem.
> > +
> > +1. ADC Channel Types
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +ADCs can have distinct types of inputs, each of them measuring analog =
voltages
> > +in a slightly different way. An ADC digitizes the analog input voltage=
 over a
> > +span that is often given by the provided voltage reference, the input =
type, and
> > +the input polarity. The input range allowed to an ADC channel is neede=
d to
> > +determine the scale factor and offset needed to obtain the measured va=
lue in
> > +real-world units (millivolts for voltage measurement, milliamps for cu=
rrent
> > +measurement, etc.).
> > +
> > +Elaborated designs may have nonlinear characteristics or integrated co=
mponents
> > +(such as amplifiers and reference buffers) that might also have to be =
considered
> > +to derive the allowed input range for an ADC. For clarity, the section=
s below
> > +assume the input range only depends on the provided voltage references=
, input
> > +type, and input polarity.
> > +
> > +There are three general types of ADC inputs (single-ended, differentia=
l,
> > +pseudo-differential) and two possible polarities (unipolar, bipolar). =
=20
>=20
> I think we actually need to say there are 3 polarities as well. As you wi=
ll
> see, my comments below in the psudo-diffential sections was assuming the
> definition of "bipolar" is "true bipolar" where it means that the input v=
olage
> can be negative. However, it is now clear to me that you have been writin=
g this
> with the perspective of bipolar only being "pseduo bipolar" where uniploa=
r would
> be limited to between a positive common mode voltage and the max voltage =
(VREF)
> an bipolar would still be limited to a positive voltage but range from 0V=
 to
> VREF.
>=20
> For ease of understanding, I think we should start with giving diagrams a=
nd
> examples of true bipolar, then move on to the more complex and less common
> examples of pseudo bipolar.
>=20
> So I will leave my commemts below (mostly with regards to psudo-different=
ial)
> as I first wrote them, but take it to mean that we are both right and the=
se are
> two diffent cases that need to be considered.
>=20
> > The input
> > +type (single-ended, differential, pseudo-differential) is one channel
> > +characteristic, and is completely independent of the polarity (unipola=
r,
> > +bipolar) aspect. A comprehensive article about ADC input types (on whi=
ch this
> > +doc is heavily based on) can be found at
> > +https://www.analog.com/en/resources/technical-articles/sar-adc-input-t=
ypes.html.
> > +
> > +1.1 Single-ended channels
> > +-------------------------
> > +
> > +Single-ended channels digitize the analog input voltage relative to gr=
ound and
> > +can be either unipolar or bipolar.
> > +
> > +1.1.1 Single-ended Unipolar Channels
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +::
> > +
> > +  ---------- VREF -------------
> > +      =C2=B4 `           =C2=B4 `                  _____________
> > +    /     \       /     \               /             |
> > +   /       \     /       \         --- <  IN    ADC   |
> > +            \   /         \   /         \             |
> > +             `-=C2=B4           `-=C2=B4           \       VREF |
> > +  -------- GND (0V) -----------           +-----------+
> > +                                                  ^
> > +                                                  |
> > +                                             External VREF
> > +
> > +The input voltage to a **single-ended unipolar** channel is allowed to=
 swing
> > +from GND to VREF (where VREF is a voltage reference with electrical po=
tential
> > +higher than system ground). The maximum input voltage is also called V=
FS
> > +(full-scale input voltage), with VFS being determined by VREF. The vol=
tage

Just to align with acronym perhaps
Voltage input Full-Scale=20

> > +reference may be provided from an external supply or derived from the =
chip power
> > +source.
> > +
> > +A single-ended unipolar channel could be described in device tree like=
 the
> > +following example:: =20
>=20
> We should probably mention somewhere that channel@ nodes are only needed =
for
> chips that don't have uniform inputs.

They are allowed in all cases. For SoCs ADCs it's not unusual to have them =
even
if nothing exciting going on because they want to hide channels that aren't
wired to anything.  For stand along ADCs that is less common because people
don't buy a device with lots of channels intending to only use a few.

But sure, mention they may not be provided.

>=20
> > +
> > +    adc@0 {
> > +        ...
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        channel@0 {
> > +            reg =3D <0>; =20
>=20
> If a chip has mixed differential and single-ended, single-channel could a=
lso
> be needed here in the case where reg is an arbitrary number and doesn't m=
atch
> the input pin number.

Indeed - that is a weird corner that would be good to highlight.

>=20
> > +        };
> > +    };
> > +
> > +See ``Documentation/devicetree/bindings/iio/adc/adc.yaml`` for the com=
plete
> > +documentation of ADC specific device tree properties.
> > +
> > +
> > +1.1.2 Single-ended Bipolar Channels
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +::
> > +
> > +  ---------- +VREF ------------
> > +      =C2=B4 `           =C2=B4 `                  ___________________=
__
> > +    /     \       /     \               /                     |
> > +   /       \     /       \         --- <  IN          ADC     |
> > +            \   /         \   /         \                     |
> > +             `-=C2=B4           `-=C2=B4           \       +VREF  -VRE=
F |
> > +  ---------- -VREF ------------           +-------------------+
> > +                                                  ^       ^
> > +                                                  |       |
> > +                             External +VREF ------+  External -VREF
> > +
> > +For a **single-ended bipolar** channel, the analog voltage input can g=
o from
> > +-VREF to +VREF (where -VREF is the voltage reference that has the lower
> > +electrical potential while +VREF is the reference with the higher one)=
. Some ADC
> > +chips derive the lower reference from +VREF, others get it from a sepa=
rate
> > +input.  Often, +VREF and -VREF are symmetric but they don't need to be=
 so. When
> > +-VREF is lower than system ground, these inputs are also called single=
-ended
> > +true bipolar.
> > +
> > +Here's an example device tree description of a single-ended bipolar ch=
annel::
> > +
> > +    adc@0 {
> > +        ...
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        channel@0 {
> > +            reg =3D <0>;
> > +            bipolar;
> > +        };
> > +    };
> > +
> > +1.2 Differential channels
> > +-------------------------
> > +
> > +A differential voltage measurement digitizes the voltage level at the =
positive
> > +input (IN+) relative to the negative input (IN-) over the -VREF to +VR=
EF span.
> > +In other words, a differential channel measures the potential differen=
ce between
> > +IN+ and IN-, which is often denoted by the IN+ - IN- formula.
> > +
> > +1.2.1 Differential Bipolar Channels
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +::
> > +
> > +  -------- +VREF ------
> > +    =C2=B4 `       =C2=B4 `               +-------------------+
> > +  /     \   /     \   /        /                    |
> > +         `-=C2=B4       `-=C2=B4    --- <  IN+                |
> > +  -------- -VREF ------        |                    |
> > +                               |            ADC     |
> > +  -------- +VREF ------        |                    |
> > +        =C2=B4 `       =C2=B4 `     --- <  IN-                |
> > +  \   /     \   /     \        \       +VREF  -VREF |
> > +   `-=C2=B4       `-=C2=B4                +-------------------+
> > +  -------- -VREF ------                  ^       ^
> > +                                         |       +---- External -VREF
> > +                                  External +VREF
> > +
> > +The analog signals to **differential bipolar** inputs are also allowed=
 to swing
> > +from -VREF to +VREF. If -VREF is below system GND, these are also call=
ed
> > +differential true bipolar inputs.
> > +
> > +Device tree example of a differential bipolar channel::
> > +
> > +    adc@0 {
> > +        ...
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        channel@0 {
> > +            reg =3D <0>;
> > +            bipolar;
> > +            diff-channels =3D <0 1>;
> > +        };
> > +    };
> > +
> > +In the ADC driver, ``differential =3D 1`` is set into ``struct iio_cha=
n_spec`` for
> > +the channel. See ``include/linux/iio/iio.h`` for more information.
> > +
> > +1.2.2 Differential Unipolar Channels
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +For **differential unipolar** channels, the analog voltage at the posi=
tive input
> > +must also be higher than the voltage at the negative input. Thus, the =
actual
> > +input range allowed to a differential unipolar channel is IN- to +VREF=
. Because
> > +IN+ is allowed to swing with the measured analog signal and the input =
setup must
> > +guarantee IN+ will not go below IN- (nor IN- will raise above IN+), mo=
st
> > +differential unipolar channel setups have IN- fixed to a known voltage=
 that does
> > +not fall within the voltage range expected for the measured signal. Th=
is leads
> > +to a setup that is equivalent to a pseudo-differential channel. Thus,
> > +differential unipolar channels are actually pseudo-differential unipol=
ar
> > +channels. =20
>=20
> I don't think this is equevent to pseudo-differential unipolar. That one =
has
> a common mode voltage supply on the negative input. This one has a full r=
ange
> signal on the negative input. This is the diagram I was expecting here.
>=20
> ::
>=20
>   -------- VREF -------
>     =C2=B4 `       =C2=B4 `               +-------------------+
>   /     \   /     \   /        /                    |
>          `-=C2=B4       `-=C2=B4    --- <  IN+                |
>   ------ GND (0V) -----        |                    |
>                                |            ADC     |
>   -------- VREF -------        |                    |
>         =C2=B4 `       =C2=B4 `     --- <  IN-                |
>   \   /     \   /     \        \       VREF         |
>    `-=C2=B4       `-=C2=B4                +-------------------+
>   ------ GND (0V) -----                  ^       =20
>                                          |      =20
>                                   External VREF

If it's unipolar, output must be positive which isn't true here.
Do we actually see differential unipolar except for the pseudo case with
common mode voltage?   Seems like a weird device.

>=20
> > +
> > +1.3 Pseudo-differential Channels
> > +--------------------------------
> > +
> > +There is a third ADC input type which is called pseudo-differential or
> > +single-ended to differential configuration. A pseudo-differential chan=
nel is
> > +similar to a differential channel in that it also measures IN+ relativ=
e to IN-.
> > +However, unlike differential channels, the negative input is limited t=
o a narrow
> > +(taken as constant) voltage range while only IN+ is allowed to swing. A
> > +pseudo-differential channel can be made out from a differential pair o=
f inputs
> > +by restricting the negative input to a known voltage while allowing on=
ly the
> > +positive input to swing. Aside from that, some parts have a COM pin th=
at allows
> > +single-ended inputs to be referenced to a common-mode voltage, making =
them
> > +pseudo-differential channels. Often, the common mode input voltage
> > +can be nicely described in the device tree as a voltage regulator (e.g.
> > +``com-supply``) since it is basically a constant voltage source.
> > +
> > +1.3.1 Pseudo-differential Unipolar Channels
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +::
> > +
> > +  -------- +VREF ------          +-------------------+
> > +    =C2=B4 `       =C2=B4 `               /                    |
> > +  /     \   /     \   /    --- <  IN+                |
> > +         `-=C2=B4       `-=C2=B4          |                    |
> > +  --------- IN- -------         |            ADC     | =20
>=20
> The bottom rail should be GND (or -VREF), not IN-. Making it GND in the d=
iagram
> would be consistent with the other unipolar diagrams and reflect most typ=
ical
> cases. I think the counterexample you gave of AD4170-4 is the unusual case
> rather than the typical case.
>=20
> FWIW, when I was first learning this stuff, I didn't really understand bi=
polar
> vs. unipolar until I saw diagrams that showed 0V as the bottom rail for u=
nipolar
> and negative VREF as the bottom rail for bipolar. Even if it isn't strict=
ly
> true in all cases, seeing the pattern was more helpful. Hard to say if mo=
st
> other people think like me though. :-)

Maybe IN- (typically GND) is appropriate?
>=20
> > +                                |                    |
> > +  Common-mode voltage -->  --- <  IN-                |
> > +                                \       +VREF        |
> > +                                 +-------------------+
> > +                                          ^
> > +                                          |
> > +                                   External +VREF
> > +
> > +A **pseudo-differential unipolar** input has the limitations a differe=
ntial
> > +unipolar channel would have, meaning the analog voltage to the positiv=
e input
> > +IN+ must stay within IN- to +VREF.  =20
>=20
> As above, this is not strictyly true. On the chips I have worked with (at=
 least
> two out of three different families), IN- is VREF/2 and IN+ can go from G=
ND to
> VREF.

That's a bipolar part I think?
https://www.analog.com/media/en/technical-documentation/product-selector-ca=
rd/2PB_sarinputtypesfb.pdf
Figure 2b. Pseudo-differential bipolar.


>=20
> > The fixed voltage to IN- is sometimes called
> > +common-mode voltage and it must be within -VREF to +VREF as would be e=
xpected
> > +from the signal to any differential channel negative input.
> > +
> > +In pseudo-differential configuration, the voltage measured from IN+ is=
 not
> > +relative to GND (as it would be for a single-ended channel) but to IN-=
, which =20
>=20
> This is a bit confusing because you say not relative to GND, but then bel=
ow, you
> say that GND can be connected to IN-, so it would be relative to GND. So =
might
> want to qualify this GND is different than external common mode voltage G=
ND.
>=20
> > +causes the measurement to always be offset by IN- volts. To allow appl=
ications
> > +to calculate IN+ voltage with respect to system ground, the IIO channe=
l should
> > +provide an ``_offset`` sysfs attribute to report the channel offset to=
 user
> > +space. In cases where IN- (or the common mode voltage applied to IN-) =
is GND,
> > +the ``_offset`` attribute may be omitted.
> > +
> > +Device tree example for pseudo-differential unipolar channel::
> > +
> > +    adc@0 {
> > +        ...
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        channel@0 {
> > +            reg =3D <0>;
> > +            single-channel =3D <0>;
> > +            common-mode-channel =3D <1>;
> > +        };
> > +    };
> > +
> > +Do not set ``differential`` in the channel ``iio_chan_spec`` struct of
> > +pseudo-differential channels. =20
>=20
> Some might appritate an explanatin why here since it is odd to have diffe=
rental
> in the name "pseudo-differential". I.e. because we consider the negative =
pin
> a voltage supply rather than a second anolog input.
>=20
> > +
> > +1.3.2 Pseudo-differential Bipolar Channels
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +::
> > +
> > +  -------- +VREF ------          +-------------------+
> > +    =C2=B4 `       =C2=B4 `               /                    |
> > +  /     \   /     \   /    --- <  IN+                |
> > +         `-=C2=B4       `-=C2=B4          |                    |
> > +  -------- -VREF ------         |            ADC     |
> > +                                |                    |
> > +  Common-mode voltage -->  --- <  IN-                |
> > +                                \       +VREF  -VREF |
> > +                                 +-------------------+
> > +                                          ^       ^
> > +                                          |       +---- External -VREF
> > +                                   External +VREF
> > +
> > +A **pseudo-differential bipolar** input is not limited by the level at=
 IN- but
> > +it will be limited to -VREF or to GND on the lower end of the input ra=
nge =20
>=20
>=20
> If it was limited to GND, then it would be uniploar. It is only bipolar if
> -VREF is less than 0V.

I'm not sure on that.  See comment on your example above. That is
what I think a Pseudo-differential bipolar channel is (and it matches the
first thing google gave me).

Key here is that common mode voltage on IN- is between -VREF and +VREF so
we can swing past it and get both positive an negative.

>=20
> > +depending on the particular ADC. Similar to their unipolar counter par=
ts,
> > +pseudo-differential bipolar channels may define an ``_offset`` attribu=
te to
> > +provide the read offset relative to GND.
> > +
> > +Device tree example for pseudo-differential bipolar channel::
> > +
> > +    adc@0 {
> > +        ...
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        channel@0 {
> > +            reg =3D <0>;
> > +            bipolar;
> > +            single-channel =3D <0>;
> > +            common-mode-channel =3D <1>;
> > +        };
> > +    };
> > +
> > +Again, the ``differential`` field of ``struct iio_chan_spec`` is not s=
et for
> > +pseudo-differential channels.
> > diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> > index 5710f5b9e958..48b88044d7cb 100644
> > --- a/Documentation/iio/index.rst
> > +++ b/Documentation/iio/index.rst
> > @@ -7,6 +7,7 @@ Industrial I/O
> >  .. toctree::
> >     :maxdepth: 1
> > =20
> > +   iio_adc
> >     iio_configfs
> >     iio_devbuf
> >     iio_dmabuf_api
> >=20
> > base-commit: 9b75dd1b7d6b98699a104c6b1eec0c8817e5fd4b =20
>=20


