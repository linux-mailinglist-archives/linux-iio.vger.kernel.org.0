Return-Path: <linux-iio+bounces-9937-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D570298A829
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 17:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E531C232C9
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 15:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4742D191F77;
	Mon, 30 Sep 2024 15:09:56 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44741CFA9;
	Mon, 30 Sep 2024 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727708996; cv=none; b=V+fQbJ8il41qbXHNXIGMGFf73J8tDnLqoE6fAz5hgnRp/VahKCO7Fq/r2M3FVnvgQ++tmDCWyu69jQn/rk2k78zPxXAG4b3lCHPVgYbBf3/yAhx2XqCVdaL5H2mySgo/EFgdxjKd1qnfdvcEgGhpiMu27dkYcLP3OHDJfXsJyQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727708996; c=relaxed/simple;
	bh=ffh4OGg7Wc0SJ9uI4dPwbwuIp4Hr2/WDElhdCAeFUuw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lKWbNhdRQqCj7Z4pAe5oyrrYTZxgQKr6zzDYLV1L9TC21YHgUi8zG7JQJ0UcFMQnfZDWHFQPugnVX31FjzUiX4cTNpoLRWOH0gXGVa2R6m5O2OZc3CEKhqu8Lw6M/s2Lz3k6V3jKkMStGBDPyEK6Ep45zmf9EfiZrXSchAwH1RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XHPbx0199z6K6Sh;
	Mon, 30 Sep 2024 23:09:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AC1861401DC;
	Mon, 30 Sep 2024 23:09:49 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 30 Sep
 2024 17:09:48 +0200
Date: Mon, 30 Sep 2024 16:09:47 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Angelo Dureghello <adureghello@baylibre.com>
CC: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>, Jonathan Cameron
	<jic23@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier
 Moysan <olivier.moysan@foss.st.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<dlechner@baylibre.com>
Subject: Re: [PATCH v3 04/10] dt-bindings: iio: dac: ad3552r: add io-backend
 support
Message-ID: <20240930160947.00007c8a@Huawei.com>
In-Reply-To: <h7ajn5c7f4d7xtjd6jwayen2v5go2vyciwfebikoxlnksodvd2@4dph5nxigi56>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-4-a17b9b3d05d9@baylibre.com>
	<gojq6ardhvt6vcs2kawdhdn2cj6qbpzp4p5mjjgwsypuatm5eo@3u6k4q7le46s>
	<418a8a9b-3bcf-4b8f-92a0-619a3bf26ab5@baylibre.com>
	<e8af0f3f-a09c-42d7-b8ca-dd633539af73@kernel.org>
	<0279203b6cd9f1312d9c03654c262c04ac12fbd9.camel@gmail.com>
	<fa27dc74-7b1f-4ef5-81dc-cc434da4ff89@kernel.org>
	<c721861809c17776c0fe89ead331b6e2e6b9d4b4.camel@gmail.com>
	<28834db1-3e9e-47f4-b00e-a548589d77e9@kernel.org>
	<20240929115919.0318034c@jic23-huawei>
	<ae4cfdfb9880e0a833c105fcb9e9442ef04f461b.camel@gmail.com>
	<h7ajn5c7f4d7xtjd6jwayen2v5go2vyciwfebikoxlnksodvd2@4dph5nxigi56>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 30 Sep 2024 15:22:01 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> On 30.09.2024 09:20, Nuno S=E1 wrote:
> > On Sun, 2024-09-29 at 11:59 +0100, Jonathan Cameron wrote: =20
> > > On Sat, 28 Sep 2024 14:20:29 +0200
> > > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >  =20
> > > > On 25/09/2024 13:55, Nuno S=E1 wrote: =20
> > > > > On Wed, 2024-09-25 at 09:22 +0200, Krzysztof Kozlowski wrote:=A0 =
 =20
> > > > > > On 24/09/2024 14:27, Nuno S=E1 wrote:=A0  =20
> > > > > > > On Tue, 2024-09-24 at 10:02 +0200, Krzysztof Kozlowski wrote:=
=A0  =20
> > > > > > > > On 23/09/2024 17:50, Angelo Dureghello wrote:=A0  =20
> > > > > > > > > Hi Krzysztof,
> > > > > > > > >=20
> > > > > > > > > On 22/09/24 23:02, Krzysztof Kozlowski wrote:=A0  =20
> > > > > > > > > > On Thu, Sep 19, 2024 at 11:20:00AM +0200, Angelo Duregh=
ello
> > > > > > > > > > wrote:=A0  =20
> > > > > > > > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > > > > > > > >=20
> > > > > > > > > > > There is a version AXI DAC IP block (for FPGAs) that =
provides
> > > > > > > > > > > a physical bus for AD3552R and similar chips, and act=
s as
> > > > > > > > > > > an SPI controller.
> > > > > > > > > > >=20
> > > > > > > > > > > For this case, the binding is modified to include some
> > > > > > > > > > > additional properties.
> > > > > > > > > > >=20
> > > > > > > > > > > Signed-off-by: Angelo Dureghello <adureghello@baylibr=
e.com>
> > > > > > > > > > > ---
> > > > > > > > > > > =A0 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml=
=A0=A0 | 42
> > > > > > > > > > > ++++++++++++++++++++++
> > > > > > > > > > > =A0 1 file changed, 42 insertions(+)
> > > > > > > > > > >=20
> > > > > > > > > > > diff --git
> > > > > > > > > > > a/Documentation/devicetree/bindings/iio/dac/adi,ad355=
2r.yaml
> > > > > > > > > > > b/Documentation/devicetree/bindings/iio/dac/adi,ad355=
2r.yaml
> > > > > > > > > > > index 41fe00034742..aca4a41c2633 100644
> > > > > > > > > > > ---
> > > > > > > > > > > a/Documentation/devicetree/bindings/iio/dac/adi,ad355=
2r.yaml
> > > > > > > > > > > +++
> > > > > > > > > > > b/Documentation/devicetree/bindings/iio/dac/adi,ad355=
2r.yaml
> > > > > > > > > > > @@ -60,6 +60,18 @@ properties:
> > > > > > > > > > > =A0=A0=A0=A0=A0 $ref: /schemas/types.yaml#/definition=
s/uint32
> > > > > > > > > > > =A0=A0=A0=A0=A0 enum: [0, 1, 2, 3]
> > > > > > > > > > > =A0=20
> > > > > > > > > > > +=A0 io-backends:
> > > > > > > > > > > +=A0=A0=A0 description: The iio backend reference.
> > > > > > > > > > > +=A0=A0=A0=A0=A0 An example backend can be found at
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0
> > > > > > > > > > > https://analogdevicesinc.github.io/hdl/library/axi_ad=
3552r/index.html
> > > > > > > > > > > +=A0=A0=A0 maxItems: 1
> > > > > > > > > > > +
> > > > > > > > > > > +=A0 adi,synchronous-mode:
> > > > > > > > > > > +=A0=A0=A0 description: Enable waiting for external s=
ynchronization
> > > > > > > > > > > signal.
> > > > > > > > > > > +=A0=A0=A0=A0=A0 Some AXI IP configuration can implem=
ent a dual-IP
> > > > > > > > > > > layout,
> > > > > > > > > > > with
> > > > > > > > > > > internal
> > > > > > > > > > > +=A0=A0=A0=A0=A0 wirings for streaming synchronizatio=
n.
> > > > > > > > > > > +=A0=A0=A0 type: boolean
> > > > > > > > > > > +
> > > > > > > > > > > =A0=A0=A0 '#address-cells':
> > > > > > > > > > > =A0=A0=A0=A0=A0 const: 1
> > > > > > > > > > > =A0=20
> > > > > > > > > > > @@ -128,6 +140,7 @@ patternProperties:
> > > > > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - custom-output-ran=
ge-config
> > > > > > > > > > > =A0=20
> > > > > > > > > > > =A0 allOf:
> > > > > > > > > > > +=A0 - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > > > > > > > > > > =A0=A0=A0 - if:
> > > > > > > > > > > =A0=A0=A0=A0=A0=A0=A0 properties:
> > > > > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible:
> > > > > > > > > > > @@ -238,4 +251,33 @@ examples:
> > > > > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };
> > > > > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 };
> > > > > > > > > > > =A0=A0=A0=A0=A0 };
> > > > > > > > > > > +
> > > > > > > > > > > +=A0 - |
> > > > > > > > > > > +=A0=A0=A0 axi_dac: spi@44a70000 {
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 compatible =3D "adi,axi-ad3552=
r";=A0  =20
> > > > > > > > > > That is either redundant or entire example should go to=
 the
> > > > > > > > > > parent
> > > > > > > > > > node,
> > > > > > > > > > if this device is fixed child of complex device (IOW,
> > > > > > > > > > adi,ad3552r
> > > > > > > > > > cannot
> > > > > > > > > > be used outside of adi,axi-ad3552r).=A0  =20
> > > > > > > > >=20
> > > > > > > > > ad3552r can still be used by a generic "classic" spi
> > > > > > > > > controller (SCLK/CS/MISO) but at a slower samplerate, fpga
> > > > > > > > > controller only (axi-ad3552r) can reach 33MUPS.=A0  =20
> > > > > > > >=20
> > > > > > > > OK, then this is just redundant. Drop the node. Parent exam=
ple
> > > > > > > > should
> > > > > > > > contain the children, though.=A0  =20
> > > > > > > > > =A0 =20
> > > > > > > > > > =A0 =20
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 reg =3D <0x44a70000 0x1000>;
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 dmas =3D <&dac_tx_dma 0>;
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 dma-names =3D "tx";
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 #io-backend-cells =3D <0>;
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 clocks =3D <&ref_clk>;
> > > > > > > > > > > +
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 #address-cells =3D <1>;
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 #size-cells =3D <0>;
> > > > > > > > > > > +
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 dac@0 {
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "ad=
i,ad3552r";
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D <0>;
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reset-gpios =3D <&=
gpio0 92 0>;=A0  =20
> > > > > > > > > > Use standard defines for GPIO flags.=A0  =20
> > > > > > > > >=20
> > > > > > > > > fixed, thanks
> > > > > > > > > =A0 =20
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 io-backends =3D <&=
axi_dac>;=A0  =20
> > > > > > > > > > Why do you need to point to the parent? How much couple=
d are
> > > > > > > > > > these
> > > > > > > > > > devices? Child pointing to parent is not usually expect=
ed,
> > > > > > > > > > because
> > > > > > > > > > that's obvious.=A0  =20
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > "io-backends" is actually the way to refer to the backend=
 module,
> > > > > > > > > (used already for i.e. ad9739a),
> > > > > > > > > it is needed because the backend is not only acting as sp=
i-
> > > > > > > > > controller,
> > > > > > > > > but is also providing some APIs for synchronization and b=
us setup
> > > > > > > > > support.=A0  =20
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > But if backend is the parent, then this is redundant. You c=
an take
> > > > > > > > it
> > > > > > > > from the child-parent relationship. Is this pointing to oth=
er
> > > > > > > > devices
> > > > > > > > (non-parent) in other ad3552r configurations?
> > > > > > > > =A0 =20
> > > > > > >=20
> > > > > > > The backend is a provider-consumer type of API. On the consum=
er side
> > > > > > > (which
> > > > > > > is the
> > > > > > > driver the child node will probe on), we need to call
> > > > > > > devm_iio_backend_get()
> > > > > > > to get
> > > > > > > the backend object (which obviously is the parent). For that,=
 'io-
> > > > > > > backends'
> > > > > > > is being=A0  =20
> > > > > >=20
> > > > > > You described the driver, so how does it matter? Driver can call
> > > > > > get_backend_from_parent(), right? Or get_backend_from_fwnode(pa=
rent)?=A0  =20
> > > > >=20
> > > > > Well yes, just stating what the framework (also in terms of bindi=
ngs) is
> > > > > expecting. Of course that on the driver side we can paper around =
it the
> > > > > way we
> > > > > want. But my main point was that we can only paper around it if w=
e use
> > > > > code that
> > > > > is meant not to be used.
> > > > >=20
> > > > > And, FWIW, I was (trying) replying to your comment
> > > > >=20
> > > > > "You can take it from the child-parent relationship"
> > > > >=20
> > > > > Again, we can only do that by introducing new code or use code th=
at's not
> > > > > meant
> > > > > to be used. The way we're supposed to reference backends is by ex=
plicitly
> > > > > using
> > > > > the proper FW property.
> > > > >=20
> > > > > Put it in another way and a completely hypothetical case. If we h=
ave a spi
> > > > > controller which happens to export some clock and one of it's per=
ipherals
> > > > > ends
> > > > > up using that clock, wouldn't we still use 'clocks' to reference =
that
> > > > > clock?=A0  =20
> > > >=20
> > > > I asked how coupled are these devices. Never got the answer and you=
 are
> > > > reflecting with question. Depends. Please do not create hypothetica=
l,
> > > > generic scenarios and then apply them to your one particular opposi=
te case. =20
> > >=20
> > > I'll throw a possible clarifying question in here.=A0 Could we use th=
is
> > > device with a multimaster SPI setup such that the control is on a con=
ventional
> > > SPI controller (maybe a qspi capable one), and the data plane only go=
es
> > > through
> > > a specific purpose backend?=A0 If so, then they are not tightly coupl=
ed and
> > > the reference makes sense.=A0 Putting it another way, the difference =
between
> > > this case and all the prior iio-backend bindings is the control and d=
ataplanes
> > > use the same pins.=A0 Does that have to be the case at the host end?=
=A0 If it
> > > does,
> > > then the reference isn't strictly needed and this becomes a bit like
> > > registering a single device on an spi bus or an i2c bus depending on =
who
> > > does the registering (which is down to the parent in DT).
> > >  =20
> >=20
> > So, we currently have two drivers (with a new one being added in this s=
eries)
> > for the same device:
> >=20
> > 1) A SPI one tied to a typical spi controller. This is the "low speed"
> > implementation and does not use backends;
> > 2) The new platform device that is connected like this to the backend.
> >=20
> > So yes, my understanding (but Angelo should know better :)) is that the=
y are
> > tightly coupled. Putting it in another way, the new platform device is =
very much
> > specific to this parent (and yeah, this is a very special usecase where=
 control
> > and data planes are controlled by the IIO backend) and should not exist=
 with it. =20
>=20
> ad3552r device can be coupled to the axi-ad3552r controller or to a gener=
ic=20
> spi controler.
>=20
> We have actually 2 drivers, SPI and platform (for AXI controller, in this=
 patch).
>=20
> Scenario 1 (SPI):
> ad3522r can hypotetically work with whatever simple spi controller that c=
an
> read/write registers in raw mode. On simple SPI (CS, SCLK, MOSI), due to =
ad3552r
> chip limitation of 66Mhz clock, the maximum 33MUPS (16 bit samples) canno=
t be
> reached. Some QSPI DDR controller seems to be around, in that case, ad355=
2r
> may work extending the SPI driver.=20
>=20
> Scenario 2 (AXI):
> From an hardware-only point ov view axi-ad3552r IP acts as QSPI+DDR contr=
oller
> plus some additional features for stream synchronization.
> From a sowftware point of view, really different from a spi controller dr=
iver.
> It's just a backend with APIes that can be called from the child driver.

Potential? scenario 3 is the one that interested me.

ad3552 double wired to a normal SPI controller (so like option 1) and
to a an offload engine (so like option 2).  With a few pull up resistors
(cs and clk?) and some care it should electrically work I think.
In that case we'd need the io-backend reference because the parent
would be the option 1 like SPI bus and the io-backend would not be
the parent.

_______________________
Host       SPI MOSI    |-------------------\
hard       SPI MISO 0-3|----------------\  |
QSPI       SPI CLK     |--------------\  | |
           SPI CS      |----------\    | | |
                       |           |   | | |
FPGA                   |           |   | | |   |
Soft       SPI MOSI    |-----------|---|-|-x---|
QSPI       SPI MISO 0-3|-----------|---|-x-----|  DAC
Offload    SPI CLK     |-----------|---x-------|
with DDR   SPI CS      |-----------x-----------|
_______________________|

Makes all sorts of assumptions about the SPI controllers being designed
for multi controllers on the same SPI buses but I'm not aware of a reason
you can't do that.

As the only control message that would need to go over the offload engine
would be the exit DDR (I think) that might be hard coded into a slightly
simpler soft IP along with the bulk data transfer stuff.

You could even avoid ever disabling DDR by just resetting the device
whenever the configuration changes.  That there is only one message
sent which is the streaming DAC updates.

Point being that it may be tightly couple for your current backend
but I'm not sure it has to be or indeed that all implementers will do it
that way and we need a binding that caters for reasonable configurations.
The question is, is the above reasonable?

Jonathan

>=20
>=20
> >=20
> > - Nuno S=E1
> >  =20
>=20
> Regards,
> Angelo
>=20


