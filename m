Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5537E3CCED6
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 09:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhGSHwj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 03:52:39 -0400
Received: from mail-mw2nam08on2086.outbound.protection.outlook.com ([40.107.101.86]:32769
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234778AbhGSHwj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 19 Jul 2021 03:52:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d41e8gdxJDY4dXrMjU1TcINwpRGx9ZW4Yg4dbXrdmmyApcimJqq1JtQ8CIxU7+nr8JxnckyWx37zYa5uEpvrs2ogcSEBcntSrsTs/kx+1QX/f/QhDZJBG0QJCX8xbV37hj4zUUc4fzknAaciMjfBdtYY0/wFVswqU9D9wRoWC1lUKH1nnv+Awx58mPRZMQ4acH19+DmwPdxZYbcRiVj1BdPHYbL1mYI1Hnqzrux13+NdqKIEtg5hAZufRF/PlAP0iMC8SfJJnjx+yW3NT5DmeFi4wLSqz/dLEUMcN7zZLWIGI3Pst56jgoo2yOjHan4199zfOLECw7TbNoGQibgbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twOsS6R0WdU5LkPpcRpgH2LrtPys1xe7dzM67JjKpLE=;
 b=n40ho00lBgOlfQOw4iq5GuiswVetcYjEdu49eY3p9dIByVKO20viTVtbaNBTbh007xMz+wi+0COrlSzY8ASasTOqmr1aDl+N6nONy1e8mLcXqi5QbAe51fUXdk+fkkJnGBZ7Ip2NvFBzvYCu4sPklAsCJPUzIQxkj/0uusT8XZKRnoDxnDEbRylfmHtqeZ5t6noYsd9QdM3Yi3YeQ2PU6viRNW7K41w0P3G64lcwwe9ruMb3IwjcqPsstu4Pa8ZNPxFDYNbHecwQAhmTxxT81/h7k+8beTb3vkQURyiN6T1e0AGGgAQaFILlAOPtsjwOZuKTHkoRjPm+7TQhgttgMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twOsS6R0WdU5LkPpcRpgH2LrtPys1xe7dzM67JjKpLE=;
 b=iS81PcMg5hTrVDPoUiNKPCiqStE0j0LSgzeLXdffYFY7ycIS4o+XC9KpVIqCiEd2Qym5YHU3WuPXQZQex3JrZnSk08FZS2tjrCecfAS4PTHrJY+zWHJSsB7I5LLAh7faMymfB89eb69VS9i8g941CkmICKtfXoKYL9YaCQMEtSk=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by SJ0PR02MB7518.namprd02.prod.outlook.com (2603:10b6:a03:32b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Mon, 19 Jul
 2021 07:49:35 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::38e3:990b:4d03:fd06]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::38e3:990b:4d03:fd06%9]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 07:49:35 +0000
From:   Anand Ashok Dumbre <ANANDASH@xilinx.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Manish Narani <MNARANI@xilinx.com>, git <git@xilinx.com>
Subject: RE: [PATCH v6 2/4] iio: adc: Add Xilinx AMS driver
Thread-Topic: [PATCH v6 2/4] iio: adc: Add Xilinx AMS driver
Thread-Index: AQHXaSbtDGFAxFZ6nESrsiS8rtP1uaszMzUAgBCU7UCAAFYQgIAF9HeQ
Date:   Mon, 19 Jul 2021 07:49:35 +0000
Message-ID: <BY5PR02MB6916EE8DDB6EBDFDAF50DD41A9E19@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20210624182939.12881-1-anand.ashok.dumbre@xilinx.com>
        <20210624182939.12881-3-anand.ashok.dumbre@xilinx.com>
        <20210704193108.20e19692@jic23-huawei>
        <BY5PR02MB69165A85F14243048187870BA9129@BY5PR02MB6916.namprd02.prod.outlook.com>
 <20210715135221.00001d4f@Huawei.com>
In-Reply-To: <20210715135221.00001d4f@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: Huawei.com; dkim=none (message not signed)
 header.d=none;Huawei.com; dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad999126-709d-443e-9392-08d94a89c0cd
x-ms-traffictypediagnostic: SJ0PR02MB7518:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR02MB751880B672D7871BE9406600A9E19@SJ0PR02MB7518.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3GChOpSi0dIZEgDpkHy61r7fq1/ckPtfGjroSfDdWDCSMGuT995O/twucMmZgXohji1gmXvTcxW4jUL+SkNz3Vv59Ldb1EYnEdAVxWxml8yuec+O/WEHOwynpooedZf6cy5CZZpVHZ0stf7zzQDBNvNskJnHHmKTEHCfjH6P3deuIAuJZsV2phU+JFgd/auMTOH9g6RieX0xTETjAvwzpk+Zkld6JoR7nmyjcUCQ3F/TlG6NvRpggEIXvk7e0AuLszowOLkGiIo51y/ZWaj19bf1TjN1gxlLc/eM0wz6RGAARoZANLnwrHR0+aREoXMb5kXv9PVgl1vL8dRkFKjCOqgxt+mp7j78KI9HbS5I1Dp/aL8PdEJWwI+Bc+2GDrV6P+aZ/K4mUs/dKrhiEQwzavPVqXOwp0Kme1jNpEmTeYr2QKkhHyU0wX2X79L2WpeU208Fdfx6Z/f+DrbYwzF//SH3rerEDvCvF4ASfpLfdpZBrddUqYwb4GXIPuNXOmtI9Y4xoMcvJnqytMNmZgljPHqWwLGaQ9UlqqGhLeNnSe0BZ3CGTmHmqHvPpKkVvPjH2toWrsFeWv4XXpnR6OAl+vi8lVe11f+f0moGETc4OzWwU4ceaQtNpWu+HN3FvRWDe+CH1EgFnxChoyUXap7ZK4z/voBfNMRv64NhMb+kylLqpCE1AxxkvzoK1H2Mddxc1rknSvM5gYNJ38IqiAKVyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39850400004)(366004)(136003)(53546011)(8936002)(5660300002)(54906003)(4326008)(55016002)(83380400001)(6916009)(64756008)(2906002)(478600001)(122000001)(38100700002)(76116006)(186003)(6506007)(66946007)(8676002)(7696005)(316002)(66476007)(66556008)(52536014)(107886003)(33656002)(86362001)(71200400001)(9686003)(26005)(66446008)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zo2u0eM1DB9oy7mwsO+XA8lRXUgYqCFBUxPTHozQHF1bqUxJ6le2k0atf0kT?=
 =?us-ascii?Q?RGIbZMi4apUcJkP2s75SHmd4BPpSnz2ki0rVjNz29ToAcbHHSfhiD4ZwKtF7?=
 =?us-ascii?Q?yeInv0gLNRVl2ACF8atQ3vfKuIG6h1P/0Pc6+oFzMq4iIKxWaNItPBWt43cX?=
 =?us-ascii?Q?YI6sxO9nyqD32RDxfuGTGFCg+DMN5XptBnTS3ngYRAj1AsN9rngjAB7ekEFj?=
 =?us-ascii?Q?KYbBhbzw8eqPBcoO2MUUbaWcHkmulUiLTBtiXArMM0nqHt/TqRfXr7WhPaNY?=
 =?us-ascii?Q?C1ZPqiJuqdeCEHj9peTo/ZG9VSk8/gpUfhmsW5oHFjqcSoPDBebQ3teLR8x7?=
 =?us-ascii?Q?jW/WunwvdjKSQjNcmOC4r1/RrV1Nu8JekI/OyU6wql8pS8BDzoO7uK1/Sxh6?=
 =?us-ascii?Q?t0pVCb+MjcdAPI0NectsQhWON+5IkcXu3ZnjqNuLxt1ahMfIKpgSLJGJVOBK?=
 =?us-ascii?Q?Z2B9zBtxU9fyp5C8OEIRN1E40QZOC9rjwzUsaHxCKAGqHH9SoXLg8v7uKfc0?=
 =?us-ascii?Q?8kfOD+lK2kcOdtlwKBKfHbW0a1MiK245+p4OyVqH3wx+90iGc7kVknyWq/k2?=
 =?us-ascii?Q?3Dv2y6QyfattlHVfzGW85seMTQO6XHFrCgbxyy6u+ojcMj+2jcaoTym7NOsB?=
 =?us-ascii?Q?IJJsSVhPsMR4RNzsCmLIYXCYwf5CUQb4zH1mle+N8p5jEOPw181PqlyzduvC?=
 =?us-ascii?Q?iN5msGp/zYRMw52f4pM3a10HXEmkVi9gMPNWFTpqsYnKZ+uh87eszc093D0W?=
 =?us-ascii?Q?8TdM3qxRDRBDuxxsM+YZDcXjNZR0P+k/EphAqO6YShxY82zWrnQWjAX+N9nS?=
 =?us-ascii?Q?utesTeHs8KhZ25yafkp7uTndNEoCts4k2/6dHLf+LLKE3Pp3qRX/zSwF+CLt?=
 =?us-ascii?Q?9M0KPcRcwMD7R9oEUuASogz8jUf1KFzg6Y8jgvqFmxXgXLb5JMv9ILeY9cXI?=
 =?us-ascii?Q?bvN0ULf/XzLQZeUCbGH+FvqLLj/cHhHoJiIVNSjWGzLoTW5C7aybrRCiX58M?=
 =?us-ascii?Q?X5YSwvJTUcFztn1aUNMzGHMlMuNeDDu0cxEVRSx3ZIpDOnXoPAAn9x5n4uj8?=
 =?us-ascii?Q?pJpSLBrJf33Wd9IFK4j0fBFA1hwFl0paBdEd0LctVpNXU3akQZna1zoJ4eEv?=
 =?us-ascii?Q?wztFs4fXeF7Uq+KgLMi28eEOs26KbbvelUrBAUTk12ofBhH3Q0FOeOd11I1i?=
 =?us-ascii?Q?F8kMURNmkY4mzSFJeMmBo+jWztMtxLdhE1oZFMHXx/P0gJcCTSt99LyLFfUB?=
 =?us-ascii?Q?MAPnqcIBXaqw/fdmGg6OVtH79603+Zvj2FBzm88IQCRkfgP50jfgx8hfObRL?=
 =?us-ascii?Q?bSgZkSAKCN3zSX4Q0yRAywWv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad999126-709d-443e-9392-08d94a89c0cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2021 07:49:35.4144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pOvSoVvLR3Jm2M6MBIcroUwrlZQNYYmzJAod2R0f9q78u1e861lXjBtR+NzPCVNlyGWrQMhJ1SZ6K3K+ePL0kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7518
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Thursday 15 July 2021 1:52 PM
> To: Anand Ashok Dumbre <ANANDASH@xilinx.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; lars@metafoo.de; linux-
> iio@vger.kernel.org; git-dev <git-dev@xilinx.com>; Michal Simek
> <michals@xilinx.com>; pmeerw@pmeerw.net; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; Manish Narani <MNARANI@xilinx.com>
> Subject: Re: [PATCH v6 2/4] iio: adc: Add Xilinx AMS driver
>=20
> ...
>=20
> > >
> > > > +	if (IS_ERR(ams->base))
> > > > +		return PTR_ERR(ams->base);
> > > > +
> > > > +	ams->clk =3D devm_clk_get(&pdev->dev, NULL);
> > > > +	if (IS_ERR(ams->clk))
> > > > +		return PTR_ERR(ams->clk);
> > > > +	clk_prepare_enable(ams->clk);
> > > > +	devm_add_action_or_reset(&pdev->dev, (void
> > > *)clk_disable_unprepare,
> > > > +				 ams->clk);
> > > > +
> > > > +	INIT_DELAYED_WORK(&ams->ams_unmask_work,
> > > ams_unmask_worker);
> > > > +	devm_add_action_or_reset(&pdev->dev, (void
> > > *)cancel_delayed_work,
> > >
> > > I'm not keen on casting away the function pointer type.  Normally
> > > we'd just wrap it in a local function, to make it clear it was
> > > deliberate and avoid potential nasty problems if the signature of the
> function ever changes.
> > >
> > > It's 3 lines of boilerplate, but will give me warm fuzzy feelings!
> > > Same for the other case above.  The fact this isn't done in exising
> > > kernel code make this particularly risky.
> >
> > Makes sense. I will revert the code back to its original and handle
> > the cases using goto and inside remove()
> Ah.  Not what I meant.  I was suggesting you add a little function locall=
y that
> has the right type and in turn calls cancel_delayed_work().
>=20
> As that directly exposes the actual function calls, any signature change =
in
> future will cause compile breakage (or be picked up any automated tools
> doing that refactor).

Now I understand.
Will fix it in the next series.

>=20
> >
> > >
> > > > +				 &ams->ams_unmask_work);
> > > > +
> > > > +	ret =3D ams_init_device(ams);
> > > > +	if (ret) {
> > > > +		dev_err(&pdev->dev, "failed to initialize AMS\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	ret =3D ams_parse_dt(indio_dev, pdev);
> > > > +	if (ret) {
> > > > +		dev_err(&pdev->dev, "failure in parsing DT\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	ams_enable_channel_sequence(indio_dev);
> > > > +
> > > > +	ams->irq =3D platform_get_irq(pdev, 0);
> > >
> > > platform_get_irq () can return errors, in particular -EPROBE_DEFER
> > > so I'd check that and return before you call devm_request_irq() I'm
> > > not sure
> > > devm_request_irq() will not eat that error code.
> > >
> >
> > Will fix this in next series.
> >
> > >
> > > > +	ret =3D devm_request_irq(&pdev->dev, ams->irq, &ams_irq, 0, "ams-
> > > irq",
> > > > +			       indio_dev);
> > > > +	if (ret < 0) {
> > > > +		dev_err(&pdev->dev, "failed to register interrupt\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	platform_set_drvdata(pdev, indio_dev);
> > > > +
> > > > +	return iio_device_register(indio_dev); }
> > > > +
> > > > +static int ams_remove(struct platform_device *pdev) {
> > > > +	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> > > > +
> > > > +	iio_device_unregister(indio_dev);
> > >
> > > If this is all you have in remove, then you can use
> > > devm_iio_device_register() in probe() and not need an remove() callba=
ck
> at all.
> >
> > I think remove will have more functions since I am getting rid of
> > devm_add_action_or_reset()
>=20
> See above.
>=20
> J
>=20
> >
> > >
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > >
> > > ...

Thanks,
Anand

