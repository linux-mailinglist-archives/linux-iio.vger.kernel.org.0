Return-Path: <linux-iio+bounces-20347-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D074BAD35E2
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 14:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0653B91A9
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 12:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A8F29009B;
	Tue, 10 Jun 2025 12:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="J7YU+aFJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97B628FFFC;
	Tue, 10 Jun 2025 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749557842; cv=fail; b=RlMsumK1pzcRy4LGCKyA7jcUv6hGSdU/m/Sc63F+sIAoTyhi9G5lrfw74lSmzRzV/jZsJWVwfIFDsInUhdtTaEvuGqIRTRdey+5kvimSgtc6vdsg7AluEGsZi7Pjx0B5mGFww6JBk0bmmpD6xY/mvJKoLN9mpCRQhCZ1Glj/7F8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749557842; c=relaxed/simple;
	bh=EbAAcU/7qfOEQ50gqXgVDCE6eEee6EmKknustViQBwg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Noq0HjxRAk6QZ29KTjaoIy8yDDjTOdE3R1tplipgzEttLas93SnzVzhfXh3CJ0zMuEf6+k/xzVVtjL9hRXvwUXCWLmtxb20HWR7e4U73fu3Y/dze/ypL22tBbXVk8dqKavok7HgrhHv/mYBlqSCdWGEewyVR+gI3ETQahEPAJrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=J7YU+aFJ; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AC55dE002459;
	Tue, 10 Jun 2025 08:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=GLj+T
	anrWQ2rFOPs5j112rZuzl1lnQ/E5yn7+gxVRTg=; b=J7YU+aFJpQSnU6uv7ofu1
	lVGi8NtGk956YXU7DwSuwQu7YwkVGlWh/xjlYY7MtBnZKne4E9cw+v4yaMlXyDMS
	RsJS9kxlu/GowCO4YbcUo95DGeoWojEPHLSD6A4Is0RdBssDrFxQkkf5R+EJhHGl
	WTKBqScPyA89VxVXfZrIcNCXWdKVSvxeEkGlfNuJqdoeEKe/Yb/EU+HYU0qzY+CR
	ToDiLijabbhHj0B1iLlh8mlmHBygB0CmTU6Eng+3lKHqgWQVEBEGRZk6J2+/GCPM
	8Xk6QXmMU7enD3rubs0uaw9Tnel4FSfGlmVREll6cUvOO/PTYSvWe2A69gwyVZue
	w==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 476fvksv0s-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 08:09:25 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZQOEaauT7zDYElUduc49cSjO+Ch3gZMDxKaV22LLYT7SA8C6ywIv4PDn2qIQi9OyBOWlLryJQFJ5e9krVANkkybsZmbaXDrBJONZCumi36L7MTHKe3gNEkqQLghpwU7DM+on1KAdY4mOOa6Czm9ito2bhexlYaVbRvVgFuFR61hJ9C4854Ip7qeXx1iBrOkg2TUglRjkeERQENJYhRpoVuRh1zPgolNAwTdYvpPTs8Jqnm2IDcwfuLz74fxfZGrFNdPMHNRAmk8MLPsGRep6nwb/TtJBGgg7o6jlOaTrc374/ceJhPx6E2dKrNCXybMSbllp+n5dO7obLHgstFXwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLj+TanrWQ2rFOPs5j112rZuzl1lnQ/E5yn7+gxVRTg=;
 b=Xbok+0XUNOLGKyVPth+QNbRVCJfV5fZv6Bt15yp9EOTJhyzCwh3iPeoZ+MhFI4rWgyj17Jw5gN+qn59lEVEiGIXgkkuamYObalyL9OzSnK9pzLy+v5NQQFvag7TaL8AwPVT8CC6YOugJD4qW09VNsl1WOsIeOi7ezIAZ537Uv+GvvORYRYLw7ucxRlAwuRf7QhMb+JnbZ2RoYu49r5y5d0FqPbHlT9zEhETFxbSI5062xhqzVfuCZyM+x+1N5gNhwu7dhzpuFB1SS6IJX/h3GYc1xLDyAL/ixi9Hg5CfBjrfKPTRQfEqj0raA3/tGKhmvRn2IKva96m4rsXEzWCZqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6335.namprd03.prod.outlook.com (2603:10b6:510:aa::13)
 by SA1PR03MB6417.namprd03.prod.outlook.com (2603:10b6:806:1c0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Tue, 10 Jun
 2025 12:09:22 +0000
Received: from PH0PR03MB6335.namprd03.prod.outlook.com
 ([fe80::6e6d:c16e:3cc5:93ad]) by PH0PR03MB6335.namprd03.prod.outlook.com
 ([fe80::6e6d:c16e:3cc5:93ad%4]) with mapi id 15.20.8835.018; Tue, 10 Jun 2025
 12:09:22 +0000
From: "Ioan-daniel, Pop" <Pop.Ioan-daniel@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "Cuciurean, Sergiu" <Sergiu.Cuciurean@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Miclaus, Antoniu"
	<Antoniu.Miclaus@analog.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        adureghello <adureghello@baylibre.com>,
        Guillaume
 Stols <gstols@baylibre.com>,
        Tobias Sperling <tobias.sperling@softing.com>,
        "Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
        Trevor Gamblin
	<tgamblin@baylibre.com>,
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        "Nechita, Ramona" <Ramona.Nechita@analog.com>,
        Herve Codina
	<herve.codina@bootlin.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Thomas Bonnefille
	<thomas.bonnefille@bootlin.com>,
        =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?=
	<joao.goncalves@toradex.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 5/5] iio: adc: ad7405: add ad7405 driver
Thread-Topic: [PATCH v7 5/5] iio: adc: ad7405: add ad7405 driver
Thread-Index: AQHb1iwW/mxdmKlf10i9kTZdlYz6rrP32cIAgAR04YA=
Date: Tue, 10 Jun 2025 12:09:22 +0000
Message-ID:
 <PH0PR03MB63351F2AA87604CC10BB6EC8D16AA@PH0PR03MB6335.namprd03.prod.outlook.com>
References: <20250605150948.3091827-1-pop.ioan-daniel@analog.com>
	<20250605150948.3091827-6-pop.ioan-daniel@analog.com>
 <20250607164428.7a245af5@jic23-huawei>
In-Reply-To: <20250607164428.7a245af5@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6335:EE_|SA1PR03MB6417:EE_
x-ms-office365-filtering-correlation-id: af94ddab-cbab-4bb7-a2de-08dda817a286
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?35GbvRv9qQVoCZvPH8iJlBgMec37wzu+4z11dk5E9YNNg9zQZIZEr7XUnN?=
 =?iso-8859-1?Q?zo6YBlBSrJh+FWmCc+cZYxaMRYtbUfQIPt3RdInChdfavIbTIJVt/jQsiT?=
 =?iso-8859-1?Q?AKghZ55h6kXh+j1GfhusPDMsTIZnmCp64+Uqffk+iOg0DYmtijYOn5WqsW?=
 =?iso-8859-1?Q?wF6XChoO+oOKslKK74ObGBH9u/qn8C2R7XRIOuxDg7aKWxVyiQQx8SyYxl?=
 =?iso-8859-1?Q?uGBdtfHEUThkXvAg5TmiWo9yrDwXdVh50s4IHf1SCxQcbHjvvv0fv/N8BA?=
 =?iso-8859-1?Q?0LYl+UOCG1WZzFzSNVEReIAfjlgoyNGSV9VNTR2qhC8dIgIiewEOP7Sef/?=
 =?iso-8859-1?Q?AGy+mkhIkeDDQ29uBYX/1sXwlN8ekshqjuPn3mdfV7DekgBbs8X8X8CK75?=
 =?iso-8859-1?Q?KlY1tWfJ6FWzOsuru6F9HAtoa8ZUNmdsy/XQjdwKZTFLgGQEnKUcbQf77W?=
 =?iso-8859-1?Q?Qqdg4ixmBi/VeG8adR9MdqTeyjv6KhslgpFOS4YGNvLXKgkProIqms1b2Q?=
 =?iso-8859-1?Q?lS2hPjmBm2CeDVphEaHMRUK5U1FkX9dHJaihrWnYt0S+p8/Z1qXJn3Gf8Y?=
 =?iso-8859-1?Q?7DkY50nPsxQEBgwHBHcjWo4qfoxgsZ1FaMa2xfvcwlPKxdAakDmVGsjL9h?=
 =?iso-8859-1?Q?YKDaWiY2FhRVNpiaYyAJJ0eJtwaMw2o4eO0irqKJPuqsI8b8Ahd7Bg2NAc?=
 =?iso-8859-1?Q?DJYScTESJ6pvj55aGL1u4JsZsyMoZsF+ZOpkNWBIT7icAULCb5qoOPRFk2?=
 =?iso-8859-1?Q?qH0I//SMKG0ZGcCRI1xAGiMTH/VNxrR3xDjayFnPUqsUtp/Ogh6VQ3OQX/?=
 =?iso-8859-1?Q?CCEeAEG9a0ZkrRWIO06ggtjeL2VWU7XjYmVgTxTerZiarBI67VAnY48Ukz?=
 =?iso-8859-1?Q?59i9V1kf6TRiIJJyHZXuk3MTCw3oaLkRcpithiaN1zg5i7X8coSN4Fsolw?=
 =?iso-8859-1?Q?BuaPgHcuPztvNYhJWvOsRuT7yNeOxckq5XWg2GvSj9wUwFAhsvWdZRcb1e?=
 =?iso-8859-1?Q?6CwszeIA61AftW5UQ8rxh6CDymuJAgn7JTP2AGvMzHG36KoTT73r5fVP6G?=
 =?iso-8859-1?Q?4442zj4NTcjNerbnm0Dvt6cRFNZj8u2wkSYypWqQPuGTi5p3aHPz3R/yo2?=
 =?iso-8859-1?Q?TDP8r8WglQtAJ9LuZ0E9jhWaZFCflgzgg7WvvaWf3GiGnqoQElYYAQxtP5?=
 =?iso-8859-1?Q?ex7AQRMFf9XPiz+NXrHGO1uy5SB8sjgU7jjPMLAhtr/uH3i1fLucz1W6mm?=
 =?iso-8859-1?Q?o2JPVap4v3jjIxDXeyQCvBWvPefRddHrzGyumntULHyhrUh9V4hGAbdIF2?=
 =?iso-8859-1?Q?O1N2yN25pP7T1bb3OkRrK1+UInNIe68n9a4Xh311LkMQBv58OZ2I172Sop?=
 =?iso-8859-1?Q?eHYTDGeLYaoe8d8cusi1HxM26Um8NkKX7zItQC8IeVj8lEJ/72IGjjwDxP?=
 =?iso-8859-1?Q?BmnGxzsHStWcgiHZ0FeOl44mM6W/iEd2Le6u4EP7Rfy0rgmk6vyxVXI20C?=
 =?iso-8859-1?Q?FmKWwF+DwAD+6AovIotPJB1UY9joFJWxb+GaVnWdRghQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6335.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CJhN04mP4vGOuh0EgKONq1yrZgBekfdkW5aQo67oK2keEWJd7ZrLtNbc0A?=
 =?iso-8859-1?Q?NNOWtPmSM5TMgtFL3V0KfGYlyClUXhV1nqGrjXbWmqlqM4DxYxlihsx+D0?=
 =?iso-8859-1?Q?b/Thkc7yxLwrQMMfR9cs8L1NTTkZidNpd+rQI4KOt2lPWqOfc5FIaI+9fl?=
 =?iso-8859-1?Q?38U67oUY/EjAaTjG736Xtkrbwydx7jTUV7ymNHZRi7vt5Q6RwO6m6zQCR6?=
 =?iso-8859-1?Q?MABlJweVEySvUDFCffPQFnCvk3Aw8uT8F/QkMuSbclvVC0m/rYJrMhAZFz?=
 =?iso-8859-1?Q?pmwtEFqIIQ5xy5Ra/t9ap/YScgMppM+EW5vzPyQqaNMuX8zC2moAnNbDik?=
 =?iso-8859-1?Q?2NptrPM9H0cn/YEqdHCt0LLpZ6dxnlOZ8+C3hGZh+Sl9yZndmZOsDrUTu0?=
 =?iso-8859-1?Q?zLXJGjWRiNLbEIQYjlbmZ37a8z2YZ7U4G6JNMC+82t+61nyFjiGl0InwGu?=
 =?iso-8859-1?Q?5bZyPQ0w05l6b9h3U4JT2yN3pbbPIL7FXp8d2D8tHKLKC4aE1sZAcV+tqY?=
 =?iso-8859-1?Q?i2h7NxVJEHjzLZrGRZb4Rx2EyokIuZlTXiRTVLfWEkWmZ3RgOCc48j7cns?=
 =?iso-8859-1?Q?HlHBjx8DaSFlsfNzxImwY6gu1AUj0LgkJslF3CCAmwe/oEnekAwcJzT81w?=
 =?iso-8859-1?Q?MHlohfh/3LjdNr5Is8owH1aDbEjvujvrEL8Y0zKzLr6qWlaCD0Yw2bTFgx?=
 =?iso-8859-1?Q?UI2GjBgZxfgKC55odWgsHR7nk/L/Y5zRl5yXNXZzO/XpBPL+x6gmWLvn+z?=
 =?iso-8859-1?Q?jYWf56yj7u5wrEBDtpQ+rsR+mLYHk9Z8eK0NmMabLQ6QgwHfwsb1zeD9eI?=
 =?iso-8859-1?Q?Mzlt/onBk71uB4c6pNivUdAn6UdFBedbM5VuQ6SJOoeIXWq/ffuYw4VTSr?=
 =?iso-8859-1?Q?d+/Phy0ZBsQtDoNoCpSf5mxfq3llm48Hv12ShRHb3NS0eA2/gwNAm6y2eu?=
 =?iso-8859-1?Q?y5Mz40vV6JQkv0lE8F+clqFFbYvupHVAjE3nZLlbcFGvth+TKf7ZZstTeK?=
 =?iso-8859-1?Q?ojdl/T9piWLCtv/bJYulr56Vwaizei6PN1LclGZYreKkxO7lfhAL7T/YTO?=
 =?iso-8859-1?Q?QThEu0vIfmFMgnyUhwltJIiRjHlTjtU4zBnvBJAf68ZjSLALnjTm6EdF/r?=
 =?iso-8859-1?Q?ZPJzKsLyER0BYEsrcxsBgndGqzNGu5Dca27BYLTSFuyi6Vend8YiA3iO6G?=
 =?iso-8859-1?Q?tfX/gybjwC1wo8sBNkQn5BEk5vjEkjd9gQ7RNRiowVRwVeRQwU0QUrlIMS?=
 =?iso-8859-1?Q?W1UTTgJEy8hNWDs2zw3fCgNP4aSdf0uE7Zqu8xNZsRy+infhj1yMXdutY8?=
 =?iso-8859-1?Q?X6nKMyBdV1AxxgR5f1EjtRrmzMo5CSDQunCit6/Npc7Vx7ozASsvaR/+2W?=
 =?iso-8859-1?Q?PtJgkRtSIbU3qHFvW1TAmOlFdyWhKwaN3KN5n/skfT6xs+06ZnztLwy2ez?=
 =?iso-8859-1?Q?5HmlHaQk+Cf0USQF5u7luhWA5jDGUC+i6SWLBzq/b+raw9BxBrONXlA6vN?=
 =?iso-8859-1?Q?UMlTfGxbPKkOhkiKYv37ZMnqpOCLa+pWQVcTx9PO35r1UDwD5Q55oZkmH9?=
 =?iso-8859-1?Q?hKz135enGe0dBwvSeNa7GXqTBB3QiAv2qUeqWi4Lu0VshDlm+sOneQa9Ip?=
 =?iso-8859-1?Q?RQxBTKiFKXxw6GB8bx7CoCOyZHnMVIsr0z?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6335.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af94ddab-cbab-4bb7-a2de-08dda817a286
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 12:09:22.0610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LYex5r/iggwKigSr+5DRbjGHeREAAFN7/EWPbAC0pUbsxL8mJU2up+ip+2+N4pI0LA8hnblUSG1IAjmclK8VABOZNW9TgjWw9cS1foRp0UI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6417
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA5NCBTYWx0ZWRfX6CN1d886YsWw
 f+PYkXxa+ZOqGGpfS/HZ2OCR/H7ugzmTAW5pwNEIbBwedNQLgAHhBsg06lYv1ABYd5hggNvjdYT
 Zl5lrwVd1utoVTIgDSw5PCYjjssBqH2Du2Sr58uhw4V96NC0h3QclUBNyMhoSfMZXlGs/FhYwxX
 pEuoILjlgud/kbw6ryk+Z4a6CFXFy0EPz3ViUikpFrSVCgdGYflpN82UnPR3r3iyoMVmwvnuO/6
 AWEeFrncxHnh+sfMyhYtEZyMcFu0S0vVaojyul7xBN8tMQd6E0x34BgvttzVftIZSFjSybmN+k6
 vhzzo7vp93GwH0d4sDMBPo+lsva2QGVdB2w7SLe7hNLMQT2tAws9SsL5NZ7uuX9WyP/dxEy8LpI
 OGpSVuPYG+ROKnHii8S4n8dgOGiPbzVPfYj9BoIVoc4onV3v6rkqfamLkPRGcGWFZa+M0oh8
X-Proofpoint-GUID: lOVg_TEA36mKB_4v0gHgVWBidvcs2rYu
X-Authority-Analysis: v=2.4 cv=Coy/cm4D c=1 sm=1 tr=0 ts=68482076 cx=c_pps
 a=5RZAJXZTQAV0bSSsSFVBEw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10
 a=dhg2QezWMjJTJo_JmD0A:9 a=wPNLvfGTeEIA:10 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: lOVg_TEA36mKB_4v0gHgVWBidvcs2rYu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_04,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 mlxlogscore=805 spamscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506100094

>=20
> Why do we need this .channel element if all instances use the same one?  =
If you
> are are shortly going to add support for more devices where this will cha=
nge
> then this is ok.  If not, just have one static const channel and use that=
 without
> looking it up via these chip_info structures.
>

Hi! I'm not aware of any other parts that use different channel types. It's=
 true that all parts use the same .channel.
Should I submit a new patch version with the requested change?

