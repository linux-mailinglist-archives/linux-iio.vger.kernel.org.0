Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5256F1BF096
	for <lists+linux-iio@lfdr.de>; Thu, 30 Apr 2020 08:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgD3Gwy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Apr 2020 02:52:54 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:3056 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726180AbgD3Gwy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2020 02:52:54 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03U6nvOV006144
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2020 02:52:53 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0a-00128a01.pphosted.com with ESMTP id 30pes2g2am-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2020 02:52:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzRtO+LS6oo1MM0r/IPXy146J6lIdZGJXMbAt14hUM7E0nkgVMBCo+PT5ii3PtLwfQu/PxVGsnnXNz0OV68VHyfS//dbWZqhNJxpWGX/l6Zti7glqmnPLvhMjhVJsNpp7ea3N/L+cHBrbxB3zlJT66z6TkEsZh2RwH/SrvRkIzGQrZViVmRgC/FKX+1KPtKPLPhQir6RBDbOFYZkqvFHVJSPWrlTPifM32pyhUIvM6gYfKVFZ+SClUPRrjwN6YsU+3gfbc81sjUIow5JHPJWtuMvGO8nIeD8mxMqw/trEyLYG8rSgxO3TcFitaysr5GPcGZCMmdtxclZpwR8zKuEcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbJx6sJ6isltCoTlgtEz/XD4QTfOlbH2+E5N9Ms1v7s=;
 b=emX3W4fIQhk1o5eauHm07M0EdR7TS5jucEYYmye9dyJvQ9ZnK8LsOLky/Clpv1OmkNrkw/2i25yw6hDwcT3ppe5tLNhUQI3gAuO/QxBzVYfD4M6ECD/3I/FlYxGns9r6Eb0b2EL1i5M4OsdpCD2w9huK2ty8R+eMVBebHCRpI9kfN4onSNQdJ6uJDjGnk7yQCiTmqymWNVxdjnf9IyL7k0Sj9Q7csACAPjS9aeUSdd9VdRt6SM3364OKI2nTBxurl2SZlG/+XB9gWmMO9abB2CpODhjys8bwFeWN1M8D6uTA6k2VHYR9KKC8NjNnoL7UhT78zOT7Hd9iiwnI+bwRzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbJx6sJ6isltCoTlgtEz/XD4QTfOlbH2+E5N9Ms1v7s=;
 b=7UOeYmcmFmCH24cHrMmrNO6+5XuXK9VeAkPXQllAMtxKorkdzWlpWkbp5QqM9Qb2yZockHOCfFXNtT5ptHDVa8WZ0i5Uhya4bVPlcLGCY/twXENyXwc0nO9aW91xzNyuu/0XBpU81foGBp9+gI/mgxjcrcU4Q46xE9JzbnsbHBM=
Received: from CH2PR03MB5271.namprd03.prod.outlook.com (2603:10b6:610:95::24)
 by CH2PR03MB5319.namprd03.prod.outlook.com (2603:10b6:610:93::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 06:52:50 +0000
Received: from CH2PR03MB5271.namprd03.prod.outlook.com
 ([fe80::903:fb7a:537c:de74]) by CH2PR03MB5271.namprd03.prod.outlook.com
 ([fe80::903:fb7a:537c:de74%7]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 06:52:50 +0000
From:   "Pop, Cristian" <Cristian.Pop@analog.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Berghe, Darius" <Darius.Berghe@analog.com>,
        "Caprioru, Mircea" <Mircea.Caprioru@analog.com>
Subject: AD 5766 driver software reset during runtime
Thread-Topic: AD 5766 driver software reset during runtime
Thread-Index: AdYeoruft+NWHSaeT7SkiSOPxDZcVw==
Date:   Thu, 30 Apr 2020 06:52:50 +0000
Message-ID: <CH2PR03MB5271407F0344001EB87E1427E7AA0@CH2PR03MB5271.namprd03.prod.outlook.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY3BvcDJcYXBw?=
 =?us-ascii?Q?ZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5?=
 =?us-ascii?Q?ZTM1Ylxtc2dzXG1zZy0wNDhjZGU5ZC04YTk2LTExZWEtOTQyYS0xODFkZWE1?=
 =?us-ascii?Q?NDZmZTBcYW1lLXRlc3RcMDQ4Y2RlOWUtOGE5Ni0xMWVhLTk0MmEtMTgxZGVh?=
 =?us-ascii?Q?NTQ2ZmUwYm9keS50eHQiIHN6PSIxMzQ3IiB0PSIxMzIzMjY5MjM1MjY0Nzcz?=
 =?us-ascii?Q?MTEiIGg9InRReTc5VjNzeStIcjlaSHpRQzlPQytYQm5qdz0iIGlkPSIiIGJs?=
 =?us-ascii?Q?PSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FBRC9G?=
 =?us-ascii?Q?UVRIb2g3V0FkdEVTY2QrS1duUDIwUkp4MzRwYWM4REFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFRQUJBQUFBdEhjQnBRQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFhUUJm?=
 =?us-ascii?Q?QUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFGOEFa?=
 =?us-ascii?Q?Z0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlB?=
 =?us-ascii?Q?R1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFH?=
 =?us-ascii?Q?b0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [86.126.143.153]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef216d0f-acf9-4fdd-aa7a-08d7ecd3198b
x-ms-traffictypediagnostic: CH2PR03MB5319:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5319E0C7769AFACB95160112E7AA0@CH2PR03MB5319.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0389EDA07F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +j04LTTaA+rN6e3HlVS+U5BPkJTvADsV024F4JH8Rk+EfCMORPHKs7GjA6nOlMQjvOn8djZHRJD89FKVwArItiZZbolIgDgNHIRwciljgO1yC1qfZvc4O2Yq6F72ci2+pIayR3NCpiZNGSyhvyw5aAd8r9aLHj6shkdxfbmrJGoi+I4by6yGvZnilcLHMOGIckZg3JNQXfhZkh6DnwxnsvcRKHZcaREVlESpU4c6f+DtqVqWEvf+zSXxC1bPuC4Akres/+OHIaD6Imvp8lZr0qb4J47GZf6NDxpUHUqqqiM/C/iTtKPCCsSaGy29xSfsU1zpIV5ZwiY5HPrNoFN5PwcasVXl9XUaUX2cju239wue8PpqCyUYXReP5XlqAJqlUHK5prTBJ8DN2KevhC+Odq7Q3UqViz93vX5BqenGMEzU3fGTshjGBqaNiWDkfQtWxxsIjzNydd1yscprS/Oy9kQIvf5diztO0123i5DLSs8ezUNEKFmzr9euqI056KwbkzXPfqhxE8BQ7/RNaf+chA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR03MB5271.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(366004)(39860400002)(346002)(376002)(52536014)(8676002)(5660300002)(8936002)(186003)(7696005)(9686003)(107886003)(26005)(55016002)(6506007)(2906002)(86362001)(316002)(54906003)(66446008)(76116006)(478600001)(66946007)(66556008)(33656002)(6916009)(71200400001)(966005)(4326008)(66476007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: yqS9gwPMfRmCrRiLRPQjoyA/Y0c9GexqCB8+Ox0B8S8kClB2zlWKkcTekAYm64IEXKj/adWrqZ4YNyDHYQQoLQVjpe6K7+wr0gc69rBZlXGa2MBAIytb563UEfu2SLV8mqw272Co3SAcCOtOq3naobuL8azpc7g2Y9PD6I4marLexP2J8OhwKn5M2RZf3QoIZ7eLkKk5LSClXkR3e77RTCAqs+4QaT7b6FVyxTmuaUM+rW80AzTRlmm5zB49JrO3j26hiAmwyfXP+yHJY6tXQD0124PkJtZLaR/tTzVt55cMcQ087qZm5Lx/6TgOFQkK9zllWF/znUwc5Gm1kfEM2GwG+3cxfQvfFgFO5DCgjFy+cK/DvzcVQMgtRPPnCC4QF68oamGaT8R3wfrZMjwmc/MacLQ2ffGjWnJ+QaeslinUB1+lAzqZA0OjJASEzcP+KWC4lOMWM5I6c4Sr6nre0+fZE78MJ0Two4UlUMJrNS37U15rVuVjvELo769bjIYAARTBCZbaykmdzxDJy0MAb5b0lL+GXoqziG8L1CsaRAyYdB9pp4oh4AEfl8Dtr0nA66VQ1uu9xQN56ZdNj/QbCx79DtQ1MSFdIysmA1OoSbt6donoZA4g6Yb/lI4pRo94turg0t95929Ya3GCrTYkPryb8Z34mRmsbyUHV/eB+bprNqEf5f/qGDCeySlNq6YcePII9kL/AY881JydZzJimpUEXCDM1V2sVE9rbp9EVfskWlfOw9V4gnTgydeAbqOA/oZ7ARHgXOxVURLb+u34ZExVKuP0ryK5oQ4OYUlh1Fw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef216d0f-acf9-4fdd-aa7a-08d7ecd3198b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 06:52:50.3388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rFCCgJc1UD4wXbbhJBKzRaKvVWdzgVYw4u9agPp7EgTzl+KQ+EtfGN2CgH2FziA2nsQjpaLSrcgVRdaEsHWijg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5319
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_02:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300054
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello to all,

For those who are receiving this email for the second time, it seems that l=
inux-iio@vger.kernel.org, doesn't accept HTML format emails, so this is a p=
lain text version.

I have been developing a linux kernel drive for a DAC converter, ad5766 and=
 it supports changing the output span range, from eight available output ra=
nges during runtime. This is done setting scale and offset attributes troug=
h a `write_raw` call. When changing the range during runtime for this chip,=
 a software reset is necessary, before writing to the span register. Do you=
 think this is acceptable upstream? Should we make the span ranges selectab=
le at runtime? From what I heard, it's not always a good idea to do reset o=
f a device at runtime.

AD5722 software reset in driver before setting a new offset / range:
https://github.com/analogdevicesinc/linux/blob/4c7d019397e696dcaf735c52169a=
92fcbe5b5b8b/drivers/iio/dac/ad5766.c#L309

AD5722 software reset in driver, before setting a new scale / range:
https://github.com/analogdevicesinc/linux/blob/4c7d019397e696dcaf735c52169a=
92fcbe5b5b8b/drivers/iio/dac/ad5766.c#L357

AD5722 datasheet:
https://www.analog.com/media/en/technical-documentation/data-sheets/AD5722_=
5732_5752.pdf

Thanks and best regards,
Cristian Pop
