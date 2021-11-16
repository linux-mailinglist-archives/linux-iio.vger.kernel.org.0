Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2F0452DDD
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 10:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbhKPJ0L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 04:26:11 -0500
Received: from mail-dm6nam10on2066.outbound.protection.outlook.com ([40.107.93.66]:63553
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232975AbhKPJ0J (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Nov 2021 04:26:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXo+BFgq4JUBZc2ctYb4j3ALOLR7OHobyY4YT8oOHAvGAI0KkLEmfpgqk6P+oqeajLuBQmgk2nycATm0vy31c4N8Sz96XC29nwVH1y57zzgjlRHLiy5W+VDeT46nQutktO+aRPkmMpE1kDwuNb1TM+cgNhxynFSZWLnp9C8S4gSRRga86EH29JkTU3JyexIAMWpMbn9IbHokXSpfjiJKtzhZWIkTzaPhQgZvYGX9LQz1LUuuIV3RK5RWy7hptJYW8N51bzYc7+WzDD32khFzEvqLUvXr3y4SnvsTkteFRpybyqaiIFgAHNnQnsL+A6JWVbt/B8YOOLLLSYIrFSkD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y90//5GxbVdJiRC9v6Cp/1IS8DPjBjNKcLukt5ou5BI=;
 b=MJZ8d8wPjkBJI+6VfE/uM0GPY6ZEaXQREf5LjgO3AIEjCAogbbbJRbJw6pXPrEXicq35WFaFMHn36hPglyz0YHGLOQmo2QkTaPJBDT1iwAUxehyAeaRwGSaYVDaknyKHWdsGWgDNmYheoHZP4J9fgiIvSXJ/oLE7sh0EUNMDt0r8K32cv81+yTT8MuzZ9C4pqhN15iv2tqY1wywEIDWm9Ojory6Z1atpPC4eR3QSaUV/jyUfLj0PpS2p9GIotcWzKMBI5eTVjBa6RmGmzpq0Yw9lN5Qa3CHUKhbMAXtI7/2xFZuf2vNkqrziEkLlPe0PValIgSU3KG94uS/fKLlNWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y90//5GxbVdJiRC9v6Cp/1IS8DPjBjNKcLukt5ou5BI=;
 b=qwL0x6XfaP820aDK+W8WEz/wN2sMqkeZsTht3OZN98fM3uhV3mNCDfXEzDTOLp/o71vhj0RqhfPKnUQArU0r2aKmITmVDlzCkgU1m+F7q5TwQCC2fDjeuBDFmEfz2hNeNwNF0w29MYjRBdEEzFY9oXiZx7qYzq61uLBjZ3rJA7U=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by SJ0PR02MB8628.namprd02.prod.outlook.com (2603:10b6:a03:3fd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.20; Tue, 16 Nov
 2021 09:23:10 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 09:23:10 +0000
From:   Anand Ashok Dumbre <ANANDASH@xilinx.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        git <git@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>
Subject: RE: [PATCH] device property: Add fwnode_iomap()
Thread-Topic: [PATCH] device property: Add fwnode_iomap()
Thread-Index: AQHX2keckvNuyh1x3kSfGREWzahA66wE4w4AgAD+5KA=
Date:   Tue, 16 Nov 2021 09:23:10 +0000
Message-ID: <BY5PR02MB6916AEC2CCB6EAE49A7FBC47A9999@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20211115173819.22778-1-anand.ashok.dumbre@xilinx.com>
 <YZKiJFpSU8kIK6Tq@kroah.com>
In-Reply-To: <YZKiJFpSU8kIK6Tq@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0ac06a6-b5b2-46c5-83b1-08d9a8e2b50f
x-ms-traffictypediagnostic: SJ0PR02MB8628:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR02MB8628AA5E80AD5F302ED4057CA9999@SJ0PR02MB8628.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V2K3OR1gjAubyXh45iR+7MZ8e0A2ygQwIS0XNwc8AdHbjOaYkYbIQVvfyrYzHlMmryWt7BNZ/t4MPXJNaqrQimY6ZI+Q0dKyhdaIRNcEzcIT5OxizkSv3dwFoytYDi+qdtkDtVTBqbVxjxfzoa732mT7YRGh0BnYlsJVDLkeueSOpRnrK6HdWs1EIrZLfPfZmmX16WX7CGZPGZMHnuydYZXArYERpaO35QOFbKkEqg1T0asUfmPQcSjsvF5SIAcdopiXfRnGmakBgGRbaowoDdx0lHqDSBnsyc0gCuXNWbLMASatZbP/HpyHRoN8E5gB9/I1Mr7NXs9bS2rzB0IZb8cJzEQc1gmdDVQgBWf6HF2a+K7rDUshNQpzxwQOi2rdWojFceWW9yiRP+JPIomuWrKdD/dnyjvaNFX/1C+FmVDuyUEOc3bHgfk2rJYMM7aWuKimgDnp/S0aD7jdJWemoc4/gGluIvK5s8cIi9qJgB5YMyQGizcvqjhq39Ba+CYfLRvAIysZu1iK2lcFSUoAZRYfENimZk04het69Ta9AR/pVSe/41ar2gGsGnHHMqjo9RSjAKapFe+RcxGoix5+hliUmCPQiBli5aLm/UXS5FiefrFQ7DWbGTRyPLWSGsARLI0JTL58ESlvSK3jhzNo4itxTCAmQ3vIH2OhpZ+gFyPIVTk5914ocfQVggSmomS3L9uXCdbQyvirjUmyC2VEew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(122000001)(5660300002)(38100700002)(7696005)(2906002)(71200400001)(7416002)(54906003)(83380400001)(6506007)(4326008)(52536014)(55016002)(9686003)(53546011)(76116006)(64756008)(33656002)(38070700005)(66446008)(66556008)(66476007)(86362001)(186003)(508600001)(26005)(8936002)(8676002)(6916009)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IhrV4hP+D4v48YB7J1c4RiqQRU7gCZMKtvJ5FMYSR7+1zmvifAGh2N8zA555?=
 =?us-ascii?Q?/JTP+dcwHjamzk6Lyxn9CT0hQLDqeqRAidM+vF+9caN0D9U5Gk9vR9llZtSh?=
 =?us-ascii?Q?Rh2cnJeAvm/XnqVbUA6sYmJnj8rQqXsiXWx/9dyxTnWyJCfJbbqGsZgne7On?=
 =?us-ascii?Q?ZotC1O8kdcVTT3s1mYFfgxjHzrkRy99wg7Ck2BjGWH/UUgzoi6/m/pNsoQrP?=
 =?us-ascii?Q?X3Atz1gjJsY12ioXuOUty10llcQb9u55xF8wMshH34UVgeGmisZ22hGg8fS7?=
 =?us-ascii?Q?QDlBEHYWy3QJRZ62ibsLXQWni+wgWF1wn8dVzOI9L1XyGpKQxQyR8jgfiIy8?=
 =?us-ascii?Q?5aWaBLEFh/GCXwHgZ4z3fSehX1N7sucdtPIJD9DjyFrr8ETBAlM6PiVOAQjN?=
 =?us-ascii?Q?Tkpn32iRgMk4aqM3XzkJn22Dlk0mpXa+NXVdCXGQHucfXBGTCbX457cTzdxS?=
 =?us-ascii?Q?C9uAOPB9+ixfJTqMBHhXwDHpH7uYmR3CyrjZiQMHdkrbzfw1YX2WeweuJAIK?=
 =?us-ascii?Q?r47nKBpT6ATbS4cdKZUQK84B0R8VxEtKEP1Ph6oIUwWgMsVVKjcqd1ktFkVo?=
 =?us-ascii?Q?CZAx0MyXgt8OUtrVqiXkxcgY8aGOv39DLniJZIHtPxqvgkB1t04jZIQNVo1j?=
 =?us-ascii?Q?eaw/u4TCdyKizQcVzEB4NMxv3kmkfEvw01sBWTCe9fiHzLXWaJ5KFw5RLSnd?=
 =?us-ascii?Q?i98e+4CaE5uDRikmtL4p0SzUmpzaR/bP373ZDO5RJEnKX5lUmH2Lb88gdN8V?=
 =?us-ascii?Q?NHyP6PEmtGoji80QH01uflllE9nsaF2Vf8+/owH9Xtensawp0dpsZAHEhMVc?=
 =?us-ascii?Q?5JT3ODVTN8xHtqZE9F195Bxud9s2L9m3r8WR88iZr5Xkf56g2vYExdzN4VAk?=
 =?us-ascii?Q?/Bqdw8c2DFBIl7f+7fKtA+iVKKNWLlQ2E56GAJ8nfWCJTL0wI+jfgkLzqanZ?=
 =?us-ascii?Q?0a7C00rucCboey60YDWMqLg4Kz2z18kzm7NIiQaHvowuPEMSQxQo/oSGhW8v?=
 =?us-ascii?Q?DFFBPpzge9OluweEjAZv2cjHe8QPpUKppJs8Lb5HUrP7Z6zg9wYkMj19BxTS?=
 =?us-ascii?Q?qyNQG/v/jJiWJVCPe9peVtFt19lPB7dBB5eSeVglcc3HdbZdh79YeWOeuZ6S?=
 =?us-ascii?Q?AlWmH6CBiXdoXEAxGiZ0/E59IKXx5/BtdHyKHqRwqDXXqHAW+G6r2A4xNdyO?=
 =?us-ascii?Q?NAaL74JLGXCNEuor/SjVoVk5LzvEZWlQRYfIcwXM31ovutuTy7/sqDqRZ7zG?=
 =?us-ascii?Q?DHIaOPkOw3/HERNZtI+baEDbrkxGeirdmvS+PdE9EYPbudf7XStYLOWfXxmV?=
 =?us-ascii?Q?bnt47fGVmZ6uCk3PCcbVR120M6bYIUM572VWWreToJVuJgPJzjFQo0VSqtgL?=
 =?us-ascii?Q?sM6mOtcD9BXjJ9p+W7S+ZKFEDXngdz/NUF2IcJeARMYH60FaHatFlCLAa55r?=
 =?us-ascii?Q?2tzI2AtFf7LkNNJCMMSSu8tFTNHrk5hWGwHYRyW8M2kiC+c6iNmrB9x+4bBx?=
 =?us-ascii?Q?yXxq7CcgBQ58f6E/4lntFLHHxOC0YuIwjQWaG3ryHtFCPDSIS1KQQD3A8NGV?=
 =?us-ascii?Q?czvOhdEqLQJwUy9RLi1fK0YPtUVVFirztGipbuqvrLvxZrUDMCKvDkIJ4kBO?=
 =?us-ascii?Q?aH8QSACdbFsuE06ooRuA58o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ac06a6-b5b2-46c5-83b1-08d9a8e2b50f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 09:23:10.1552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gTFJFF3ChTU1ZwgiGYR+UjxPMggFlDle4B8HiCqSbdqW5/jSPdhOsQaI0bOGdZWcZEkyGd0CrRb7gUn7kTfOZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8628
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Greg,

Thanks for the review.

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Monday 15 November 2021 6:09 PM
> To: Anand Ashok Dumbre <ANANDASH@xilinx.com>
> Cc: linux-kernel@vger.kernel.org; jic23@kernel.org; lars@metafoo.de; linu=
x-
> iio@vger.kernel.org; git <git@xilinx.com>; Michal Simek
> <michals@xilinx.com>; rafael@kernel.org; linux-acpi@vger.kernel.org;
> andriy.shevchenko@linux.intel.com; heikki.krogerus@linux.intel.com
> Subject: Re: [PATCH] device property: Add fwnode_iomap()
>=20
> On Mon, Nov 15, 2021 at 05:38:19PM +0000, Anand Ashok Dumbre wrote:
> > This patch introduces a new helper routine - fwnode_iomap(), which
> > allows to map the memory mapped IO for a given device node.
> >
> > Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> > ---
> >  drivers/base/property.c  | 15 +++++++++++++++
> > include/linux/property.h |  2 ++
> >  2 files changed, 17 insertions(+)
> >
> > diff --git a/drivers/base/property.c b/drivers/base/property.c index
> > 453918eb7390..9323e9b5de02 100644
> > --- a/drivers/base/property.c
> > +++ b/drivers/base/property.c
> > @@ -1021,6 +1021,21 @@ int fwnode_irq_get(const struct fwnode_handle
> > *fwnode, unsigned int index)  }  EXPORT_SYMBOL(fwnode_irq_get);
> >
> > +/**
> > + * fwnode_iomap - Maps the memory mapped IO for a given fwnode
> > + * @fwnode:	Pointer to the firmware node
> > + * @index:	Index of the IO range
> > + *
> > + * Returns a pointer to the mapped memory.
> > + */
> > +void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int
> index) {
> > +	if (is_of_node(fwnode))
> > +		return of_iomap(to_of_node(fwnode), index);
> > +
> > +	return NULL;
> > +}
> > +EXPORT_SYMBOL(fwnode_iomap);
> > +
> >  /**
> >   * fwnode_graph_get_next_endpoint - Get next endpoint firmware node
> >   * @fwnode: Pointer to the parent firmware node diff --git
> > a/include/linux/property.h b/include/linux/property.h index
> > 357513a977e5..9bb0b0155402 100644
> > --- a/include/linux/property.h
> > +++ b/include/linux/property.h
> > @@ -121,6 +121,8 @@ void fwnode_handle_put(struct fwnode_handle
> > *fwnode);
> >
> >  int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int
> > index);
> >
> > +void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int
> index);
> > +
> >  unsigned int device_get_child_node_count(struct device *dev);
> >
> >  static inline bool device_property_read_bool(struct device *dev,
> > --
> > 2.17.1
> >
>=20
> Also, always run scripts/checkpatch.pl before sending patches out so you
> do not get grumpy maintainers telling you to run scripts/checkpatch.pl
> on your patches :)
>=20

Sorry. Will do and also will send it as a part of my other driver series.

> thanks,
>=20
> greg k-h
