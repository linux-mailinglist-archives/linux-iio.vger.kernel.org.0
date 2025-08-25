Return-Path: <linux-iio+bounces-23198-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006DCB33BF8
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 11:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08773ACF00
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 09:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7165C2D1F7C;
	Mon, 25 Aug 2025 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jkr0s54L"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF27280018;
	Mon, 25 Aug 2025 09:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115630; cv=fail; b=XbFpmcK2/tMoQK72by0IYL/PBqpFobiYT39LvxSF7Wx6Bbd6RddPS4xea87pNpJ3MM+dxWhCvVrvb1l5FXmHZVbn/HzvzV2GfcYhhsYDtkVYiQP52nBc2kAKcah8+/DTWS8m19V10b0QpA4gPCAi2FHQ5SkhKgkbHhLQgoMfpCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115630; c=relaxed/simple;
	bh=9UmU8y9TSyvIdLPC4o+obnyuqNdoTLv1z3CB0l+XfRI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NZvbb39ZdLdlCE6zbV2Z5kg8ZnApopgPGxtbuqzti9QAJGXMNM1SWfu8gvtK1g8y7O/FVKRp5tYZGIFELrDqOT4cbMoJ9Sri4bELOq+pKjy94zvG/HzOxf3Qak6FW6YqzXUPszxPOYFbRyebFSHNnZzwUh4AZBThR+gA++W/Sgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jkr0s54L; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnUw/1Gz2FTltoBJO1ofPAknMPeGD6A3Tw/V2v5OxPHFKYITbRcKNc8304XRhRw4lBz8b7bwvQifT2PTRTSAQW83NoEghc2Snhfx7VUfAiDoUTc4QUhnewJdh8z40R1zDcMRCBF/77Pa2Qrc28RCnATCeS4QFCXyCh88WUKmglYWPVu2DqemBq1jT2L0/BfCNqFmTH5nXKXpTcRUZHpwQCWlukEFabXoE1ZzYN8duVjBVMcyHbfzh7U4pTY2YI7r6GaMew+9swenGesNWid+bvVeZ8giUZYjHZRsz+RvS+f1z89N0UV/5hE1GE1+Snm613c7/XPQ+bi61o27IyXuKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UmU8y9TSyvIdLPC4o+obnyuqNdoTLv1z3CB0l+XfRI=;
 b=xzJRfH66YtnXuU2HczjcQLd7JRgns2ev/xV4euGXvZUicTFWVMYK/R/M10WOlEcCpmBS6rns3fR72sicdujHvsP1XZT4Hb5xd1T6Mr2ZV5IGdu9aXI/mVJIM7mg3VSyl8h97uNJlSwTNLdw53M1GCjn787clI5rM18Vy+uWBkYIifmvsO2fXKFGIqPAUcr9qExYToEHlGIH0hTRzXtaBjOCP/plg9tb6PIlDnkGlfDE3RUQfyYaDNIqyLzXSAVzyVfOZQjH013olhE7hEwJL9udfWeZY0vA7fl2K8JYTmL7xw7VmDRMBu/DQ4esXgwTrJ3rvuRL+0HLxQTpFu2TgAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UmU8y9TSyvIdLPC4o+obnyuqNdoTLv1z3CB0l+XfRI=;
 b=Jkr0s54LyzlVgt9Bao+WMPDcYEBQkkWdXnW4zvcE1I9+DS2I/UpnQ2yf65UFXLz4tz3wMQielaCWfZcZdH2AUwRp2nOTnr4KK/pWsU+Ve6tWaafwwxYTrA3mrVgMAHXjdVF9erzGIc3g2D1g3xw/ArQt/ywtD8KDJEKcG6T6rbU=
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by DM4PR12MB7672.namprd12.prod.outlook.com (2603:10b6:8:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 09:53:44 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::af21:b877:699d:43b0]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::af21:b877:699d:43b0%5]) with mapi id 15.20.9052.017; Mon, 25 Aug 2025
 09:53:44 +0000
From: "Erim, Salih" <Salih.Erim@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
CC: "O'Griofa, Conall" <conall.ogriofa@amd.com>, "nuno.sa@analog.com"
	<nuno.sa@analog.com>, "andy@kernel.org" <andy@kernel.org>, "Simek, Michal"
	<michal.simek@amd.com>, "krzk@kernel.org" <krzk@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v2] MAINTAINERS: Update xilinx-ams driver maintainers
Thread-Topic: [PATCH v2] MAINTAINERS: Update xilinx-ams driver maintainers
Thread-Index: AQHcEbn4jbBGSQqtcUiYMM22c5pVubRwbioAgAKiUACAABgRMA==
Date: Mon, 25 Aug 2025 09:53:44 +0000
Message-ID:
 <IA1PR12MB7736D5945F1AF7690E4497459F3EA@IA1PR12MB7736.namprd12.prod.outlook.com>
References: <20250820100519.2272509-1-salih.erim@amd.com>
	<e61c2e01-cd8d-4193-afcf-5ddaef34300e@baylibre.com>
 <20250825092634.75230a7d@jic23-huawei>
In-Reply-To: <20250825092634.75230a7d@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ActionId=a4c31828-a3a8-4bd5-a43d-c3bd6b1f8746;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ContentBits=0;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Enabled=true;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Method=Privileged;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Name=Third
 Party_New;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SetDate=2025-08-25T09:53:40Z;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB7736:EE_|DM4PR12MB7672:EE_
x-ms-office365-filtering-correlation-id: ffdbbf1d-eb99-4d61-9a6b-08dde3bd4758
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QorDUyM3PJ93iMiIy7qG/I3jJ/WLnRKg9O2VYaHmbk+tC9np7CDDFfblmi6a?=
 =?us-ascii?Q?QdWLAXnoYLXuktxis5fE33i46d0eQRoK+Ec0ZekvxzYylX/5FU64U6PGrSOa?=
 =?us-ascii?Q?Nrj8bGW3WrfJ8MeGgdjDj33Jqwn05yVyBNBYsjQnm3aDb/E8VDTwrkul7qMa?=
 =?us-ascii?Q?hvaxPcYrwRRri53IzN3T3yFr2oJYkf+g06xy7/DRnhCRXHvzHUqJdzn3UoJZ?=
 =?us-ascii?Q?aVTpOM5bSGS27UyVSmKrqKOjmMlfENpeQxeAUS4MjhQBrZAJ1/x3wP81jb78?=
 =?us-ascii?Q?Zn8kDH0ihrSWbt8bcXTGmi9AjJTVKzTs1PamrqN2WKwuVsl4u6kzPYxwr3gt?=
 =?us-ascii?Q?w/O8rTos/aLFo1yJboBbOphK5wY+ndUrU0B0N3j6inG0rJMQHMRdmkruKGtX?=
 =?us-ascii?Q?p4v6jXwcaWoGzKfVfEtfRnbFzOUeTDoYEGT0ZUhSWe6oJYTEN94RLcFExAcn?=
 =?us-ascii?Q?aXUDLi7twEfmkrApTTTIBO7lJSxUhtP2Umv/OZgOMpSig7vHwcZ5PQCuXOGA?=
 =?us-ascii?Q?RNgXVZAHZsq1JdP31hVrP3kWAfop1+pfIULfhEbrWRTFQPo9Qof03EeA0ZVB?=
 =?us-ascii?Q?RsE5kCCnhtkc//41d4ZUGGb0hzb7zvJxssSf0U7rqjy5t8XXqnhATxt2MLOl?=
 =?us-ascii?Q?z+I+hwphCtyJ8uSVJVw7BMnANv2z35o8lyH0UBcwAOa/KwEfPdcYEBcXU/PI?=
 =?us-ascii?Q?WJ6mLqePSChYYnN2SZiEpbASYR0iNcHpiS7ykwMyvgNb/EjMhA0g5ocLw70P?=
 =?us-ascii?Q?e/A+LJKbsTSk1E/xyZkgJORKYSTQHyHSIPECgMc3guR/uYU2jCtP3bzNEKfv?=
 =?us-ascii?Q?vpML79hj5uyGzvbwejtifgYLb3IEiLDasWdfQZCW/d+2Z9n+FbqmIT5YydQ9?=
 =?us-ascii?Q?VJ3pX5J0gv9iJQCiixasV5m2KSujmw0a4fWI+MkJZptspRKyGpozYWUr9A6Q?=
 =?us-ascii?Q?gKvR35ir8WhXmq0ZkY0BdHnK+5s+inqYH+jvoh5Dqa9O6fisfGpLjXiRAJ1Z?=
 =?us-ascii?Q?/akfpE4k3W988eoGBHk4bqqQBCnDCq5GR/7YBXR3vVUvo3Lflk7kkb7TPM2u?=
 =?us-ascii?Q?EYuy4mtqlldVt/vA/PTB5l/uxC8UlbMiJSqAOm3E85gtcM3rGwlSVGE1TDNy?=
 =?us-ascii?Q?cJ7X+mOyv4dJSf+TeVmI6uJM95EKmIHzoeejYc17VAOBK+f4oQ5H31fZ59l5?=
 =?us-ascii?Q?2nzUlEZMVusvuywJIzHo8+vUyTqwuOH2gEkSNeCshdEGSQo5g8vfotVHycRU?=
 =?us-ascii?Q?Rm5+Fte+Yw7NnEJHonSlAz6Iy4FUX/M/EBWw/EJZ9x3wXrZV+FbZpC8MuNEl?=
 =?us-ascii?Q?EsaH1gP3v8UIlHYTTHOTAkKZoFghmVqcBvfsTJmlLKr3MTIfmWuHyEA1Uwxe?=
 =?us-ascii?Q?bDl6x/77VxLht+SxuD4pnR5WNdep2AiUGQNIzT2BrxmMxOf/XQopESsH2q3X?=
 =?us-ascii?Q?rr/Nqg1yqxtXMGGxQY/wEBaEsBciMDa/zOKJmK+LWJC46RFB9Iyrqg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BhJ3CFMYn/QgwvvcNSQ1Lh8LPNKhb+Ka+Cuk6wDJ2DXAhcBq88D1SPDEbpr6?=
 =?us-ascii?Q?JL67LZ43p0hg8cl5ox+GCQvWiE3YlZ0l4/uvXwc5aL/OOkmWnGh/6WtfUXMt?=
 =?us-ascii?Q?PrBRW3sSONe77vpO0vSyci5zLnWVWhqVrpe58k1A5yoMVG7C7pYZR7/2iXGQ?=
 =?us-ascii?Q?YvLdFCAp2ttF62O/gnIpwp+cUIwwOUqL11/4SMBjTKU62Zuax4cy02+J1c/H?=
 =?us-ascii?Q?M4WIYk5BOIXTeb6jpW1irRaGLjEtPBrlfZ0xPnWRCtN4REcRQZAZmZSDRWDn?=
 =?us-ascii?Q?KicJsnR7eDNJojNhfz8ajOS3zyqVh+wCcEW85zzJqUBjMXzuQ+hCjafmgSPO?=
 =?us-ascii?Q?yaWIhYDr9INCVlaxebZT2uuzW3fPcQ0UoTuy2rS0OZsnul/5kjgF1l7wztqb?=
 =?us-ascii?Q?CBMeICY0M2tAF0MxppYeM9Jz7zZaif9UrSD5VNH+B3XEDGznUteqjBhx6O67?=
 =?us-ascii?Q?78edGjdYlpv9PX5Q+BrX6zUNgcGcvdMCqg/XEgbUC98q2ic8zLa+DEHqNAFB?=
 =?us-ascii?Q?9SE3Xwsqbjy/5YYevX+0X9G4vgyiOPHR2Ya5QL6zmo3eyyHy0EKWJrRTl2gn?=
 =?us-ascii?Q?gdi6godQ3S8DYGiOihyyqPIR/7BqEhoSoO9I55+9F+t3fxTegEgDaEarKK5A?=
 =?us-ascii?Q?aBdoujbzji/I049fh1LCyGkOqvCHmJL42yaJkxTdWw08Rgy76aPal3xPQSkj?=
 =?us-ascii?Q?pXpjrA/Iq+069ISAPxAO8z+It1N+nKP0OAus8uDISEpIWQB4F/+e+bURUU1A?=
 =?us-ascii?Q?h071cOULnYybBUrtarjni9epkZ36x/5aiMzCOogXa8YArmga15z9b5GGuTVb?=
 =?us-ascii?Q?YZvAYwVvojQR3xFZQ8IojXHJCd6D9T6PfQ8iOgh+pvlMamttE6zYcubMlhPW?=
 =?us-ascii?Q?K5rbpNsn85ZWtZSEIw2EAhCthlDGiQEl1LDDQMTgUsBZJyAimMc5ZEitbCKa?=
 =?us-ascii?Q?89M765pif4NiLWRc4pe6sQAlTvtq3vay9y+N4zyimyvMKUQstRlT2EzRWHsz?=
 =?us-ascii?Q?T0E8CIyqBMAMhqBrAE6MKltEhfbrKjQcALtmejg+PknzJTaKL00y7YJ27vEY?=
 =?us-ascii?Q?mpXfPNqQHFrFNq9Q8cNaWCRqedmA6RKlNrj7loU58nIJmMJxXtn6e1VhXvwv?=
 =?us-ascii?Q?MNGln6AmIGuS0Q7vVsnef9fW1uQSWjcV+KO7aZGIt5youfikkC9li0jcOdsM?=
 =?us-ascii?Q?zCQ7bcoYST8CzTuNxxFzdfSPBrlOAC/ac+Vnl5NoZs786z8+NyrHseTHZBwZ?=
 =?us-ascii?Q?DNqd3MiRRuRQKfvICun5UuavpREW3qE5wPml7TGyKmjg8jD28YvYs86EOjP8?=
 =?us-ascii?Q?MWXMTTa7yrdq7p38mO4G82KXUnLiTUKU7I7Zfi6k0WNAL2VMEwo7MdRWWdGP?=
 =?us-ascii?Q?fwPbZr4ajbABgNuezkRANilIFNPJkxgb6qTpfDSS5UVJTm4equZHdxoOAzUH?=
 =?us-ascii?Q?qolZ/YgfU4MKOoE4kGmUH3f/D/G0QpiBh92mKEo/l/nG1LISFaG/iJpUEjaC?=
 =?us-ascii?Q?UzeiIyMi60TuNA4dta1GJDp1fw9ncylhD1bm9Os57ob5gry9tdXzrGeZi/6X?=
 =?us-ascii?Q?5xJQ13X0pfP7spbRZnw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdbbf1d-eb99-4d61-9a6b-08dde3bd4758
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 09:53:44.1585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yjTgmkIJ+h8Qh6m+ffMLcHCTIpmv8CRlBLk0YSXwPCFglPCu3ejuPpKUajeLjFLv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672


Hi,=20

> On Sat, 23 Aug 2025 11:13:06 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>=20
> > On 8/20/25 5:05 AM, Salih Erim wrote:
> > > Anand left AMD/Xilinx some time ago. Salih and Connall are new
> > > maintainers of xilinx-ams driver.
> > >
> > > Signed-off-by: Salih Erim <salih.erim@amd.com>
> >
> > Looks like you forgot to pick up all of the trailers from v1.
> >
> > Also, there should be a changelog of what changed from v1 to v2. Just
> > rewording the commit message, I assume.
> >
> >
> >
>=20
> Looks to be just that. Something to fix for next time but for this one, a=
pplied (having
> dropped v1)

Thanks Jonathan.

