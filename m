Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CD15E9962
	for <lists+linux-iio@lfdr.de>; Mon, 26 Sep 2022 08:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbiIZGUv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Sep 2022 02:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiIZGUt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2022 02:20:49 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8595026AF4
        for <linux-iio@vger.kernel.org>; Sun, 25 Sep 2022 23:20:47 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28Q4nb3T004468;
        Mon, 26 Sep 2022 02:20:23 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jsxt71ske-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 02:20:23 -0400
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28Q6KMDI025516;
        Mon, 26 Sep 2022 02:20:22 -0400
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jsxt71ska-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 02:20:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVgpKkYjJeDK0mv/QmiJznzJuckRZfWFKkHw6cqnDUoqcTPKm2xy/ZCWMsjEyq1fJU6ZCOn8oHHmr19NFzG48hQJaRYGP85ynWjAN8/QGvhSq5h/Jjt0ImulyfU11YEileOkYFA+gmhoIwy7zwNh4oPqkDtYJS/iUFQF2voBSSVJlFBXMwiBgEn66L557n72fiOD3JB6KzQ8Wj/MNyTXdORxXit5ZNgIUoMcCRErPvaYG4WIusA3TrM6qNrNSl1iwXeBkGiodL3cWuEskWsqLbg2WF1AQ5LxsZM2OpDenzsEgBln3bfafdZlQpnj+3KFfDgVz5FeNC27B5oHRmQKOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1p1WCWLToI/TZExbmFOtEjpqA/KMxZFL514GPTwQtw=;
 b=LHqh4iQY83osX+ZoAlmuSQSfce1edoOQNgACaHI1BP3qU/K2K5AVgbCBCFpxVSzAXH9+iV488Oss/Yj99g4yHksRKw7gH/+eNoc/bmc5GrLQV5I9Szbg68K3/0n6cnvapsjuJVtqchhg9lbtIpPO+0OW/eHGBtk7SBk9IVyMboTIWa/x1beo7xMGm/2rZdBJbQBy1Mv5PMbbiVGMGWDqw+93oBbjljnzwUoqDC0QTY45xLmEVJDOoIgdiFfWRQeiQBMySryVIsTIGDDWRAiYtVlepPbWJInEJCgRLYxsuE47Kbd3YvYPptFEJ7UcbCncL5u+e9lXIjx7O1sdiadN1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1p1WCWLToI/TZExbmFOtEjpqA/KMxZFL514GPTwQtw=;
 b=EALliq0sRc1q1sfqoV30eD1ogGtVE2Qvf/X6xbE1nOntLiuwSmn7vIkS6TgZxdi99t0ulF/UwZbUne18K+/0Mlhz1Yg/Q2cLSoms8D7QmapUOdC10ToPOT7JvFT1xhpMdRCpFsAM0cwL7IQJ+r96WoyL5r5qhapy9xWuwxcPVfA=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by DS7PR03MB5544.namprd03.prod.outlook.com (2603:10b6:5:2d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 06:20:20 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::f8c4:a01:3135:a408]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::f8c4:a01:3135:a408%4]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 06:20:20 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Wei Yongjun <weiyongjun@huaweicloud.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH] iio: filter: admv8818: fix out-of-bounds read in
 __admv8818_read_[h|l]pf_freq()
Thread-Topic: [PATCH] iio: filter: admv8818: fix out-of-bounds read in
 __admv8818_read_[h|l]pf_freq()
Thread-Index: AQHYznhJqBIBVjDSV0Kn/DKIsMjtLa3uz28AgAJytdA=
Date:   Mon, 26 Sep 2022 06:20:20 +0000
Message-ID: <CY4PR03MB33994103D029E15346CC99049B529@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20220922115848.1800021-1-weiyongjun@huaweicloud.com>
 <20220924175336.3c3cadb6@jic23-huawei>
In-Reply-To: <20220924175336.3c3cadb6@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdXNc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy00OTM4MTNkMi0zZDYzLTExZWQtYWQxYS1kNDgx?=
 =?us-ascii?Q?ZDc1MDZkZGVcYW1lLXRlc3RcNDkzODEzZDQtM2Q2My0xMWVkLWFkMWEtZDQ4?=
 =?us-ascii?Q?MWQ3NTA2ZGRlYm9keS50eHQiIHN6PSIyNjAxIiB0PSIxMzMwODY0NjgxNjgx?=
 =?us-ascii?Q?Mzc3NjgiIGg9ImU0ZG03a2Y1eVZhanJCRXdkVUtJS3FvK1Rlbz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?QW92SklMY05IWUFWWE5IcUUwenRVOFZjMGVvVFRPMVR3REFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBbTk1clV3QUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|DS7PR03MB5544:EE_
x-ms-office365-filtering-correlation-id: 50305e05-58ef-4943-d49f-08da9f873025
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RsErq40TnKdiuqJihJvZHRYIfBFR0JIMI1n9syQklMVS5j2dI1WghfbWZT+akGa7K/qSHk0JIs9l/bcE2BWawCypg4iFR0AseY8DN4exjlGaH2snvcWIYfFQvYIR/z3hDNSvWoiG5B+0nXErH+iqd/zEaUrWRYh3Er5D/6Qe1VCfXPZX9DwCgF+ui1n/Oi63arkJFJ9P64zlh7z1p5TSRgeQrK3h6WlkQOHk/DVcMoprLXr93iH1KCRu4BglkIJsVwJ/9aZZmnwY35wHlKV/SVKfK4DmIEBKDZAvXKauUuhYc6q94ItGYaSVdPq4FN0MdZrpIlaXopcvQFolS//DTSKmixZ8Qnzi7JkqOogCiNcDAOIEwITp8b1mW/KZR7jliDeH/8tS9HuXpwE2ArDdu2y0d8+lWr/N2tMMRecwH76CAapPW+YIYRqD45L2GELkKPKgHbpWsnaL2N/UOeZji/VU94M+PKkGzaZ/ZYJtckirCVpGw8+OEoTpTMII/ix7eJis/tezezckwA+NHhfNznPEiuXck6tWQWd2J5XvX38SMjLUICDSP/QqiwtIVHfv9IOPhqrySWK/LK2eNCowEqXFs6cWsidW/iSEfT2SKvQlg8Eid7KJAXxemoiMhq14Y5SJyhjep32hxa/baC/nSrNMU5PenQyU/ZQDf71uwjTufjfiauiefjKH0DtOp9PprAvXnS98aMk/cpHqj4MN/OIfeWBIzUVQj3ZWTpVS5SQ//w/53jtR9iBUuEAlPeEyQPL8kNNHVEJV9c6wBOa0XA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199015)(38070700005)(122000001)(38100700002)(9686003)(26005)(186003)(41300700001)(107886003)(83380400001)(7696005)(53546011)(6506007)(478600001)(8676002)(66556008)(66446008)(66476007)(64756008)(66946007)(4326008)(76116006)(71200400001)(110136005)(54906003)(316002)(2906002)(33656002)(55016003)(8936002)(52536014)(86362001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cl1Tzgu6BLwA4fhdECzGJ7CxWhrwFDUdSVRhbypevtR24uLlTP4CDyLsqVi9?=
 =?us-ascii?Q?+xrNDxyU761VqDXETJmgkwfE8/C9WdGIbI5Jpi0h94xKnqsh+lV6RJpBSRLm?=
 =?us-ascii?Q?+lo8n/b5JrqUHelXANLvt/j0BkLcvjzrNKf3IoWG/FHin+XoztoZ1RnfM7y/?=
 =?us-ascii?Q?raNNTRyjFGiYH+3E8vyMJtRNnsRW0PqmbeMTZG+5Nv9OKAI1hfeQ8qtaziPN?=
 =?us-ascii?Q?bFZvPL3Ae3F3Pr70cTI+ghoZVRYrZ4YpnrLa84kAxo0ZkRhSG1hxYLj6kqtH?=
 =?us-ascii?Q?iqPhMnEdfbMe837mcfHwvIXY/xiiw/DmltJZuL/BGKBuUDdvd9URSn8AdIrr?=
 =?us-ascii?Q?rzupOuPFSsLNw312u8WqpLzaHhxQJSwDblfHQbVhq7zcREYIPDq9UftMCSsj?=
 =?us-ascii?Q?Jh98Ddj4HmcKDajkUKzkkmoJyHVDmktqvopQMBNuZz0ID+HUYtaHUhULhZ6W?=
 =?us-ascii?Q?cv07RMTeyYARUHIoiNlTjblj4LCQrGs76O+NEQqdF+Gwdd8WFdnQ6a6rYotY?=
 =?us-ascii?Q?D2rMWXA3VVtnbHUmLMSgXL8OCtOKWk4BcqQGh734Y5GrOshVocbVoAqjqzse?=
 =?us-ascii?Q?nN3lCYTEWGRLu5fKMSi2bpZX4g8uX6QADlRic2KMoT3me9NM8e2ihdJuDTPg?=
 =?us-ascii?Q?wxCepSsWoE5t6pwD74JVKBbKEI+0QJni5+H1xuSHuIZffX2gvGgNx5Hd6Cew?=
 =?us-ascii?Q?N4OOOeujqzFY+nIz4lOVcQtB8s+XppbXOH2g1u2qOHFzW12XqFYSRX64AIL5?=
 =?us-ascii?Q?wzRDlJHAyi4bZWNvfoGz2aUi5HO5XKdXRwKAOMme0SYdIhlt/U9RIKRjzwCL?=
 =?us-ascii?Q?t8dP3aJxowORtWpTCPHKrnD25ZhshGdib9e1BUYNIYDilh9craFlexyc3Pqw?=
 =?us-ascii?Q?dC5gUtAH02yDFUGOfG1vnlYc3ycqT0CTqegbBNqxJWZVcSh8AUPwebMrd8mM?=
 =?us-ascii?Q?4RX229UD8skzbIdsRBNsMSFs4XqTTA28nic8CNz1lXEceTtlgkVFCk+ZXAj3?=
 =?us-ascii?Q?KHdKYvQ7VBhrhznKmD5eU4VC7T6Bz9Gi62Skcq/2cnPw9NdTABQlXSgs8nad?=
 =?us-ascii?Q?MxNDxM9u2d1JwE6N+4Et1I4M0jIn7SiwMn3O0MZiau4Kho7zXzN9vk7k4+g2?=
 =?us-ascii?Q?AxC7IuPlMsj9JFUUEz89Fweo1pNSNtX3TEdWAl++/gZwql4jsueK4JRMqOJn?=
 =?us-ascii?Q?oXvzdEa2DYSQtQBcDC4wxhPmA4iWeVBHIStHI3QVaE+fiGHl4tj+5V46kuQz?=
 =?us-ascii?Q?h2QJ1wxD3SNk/2U8Ph3gyl71dgr8t2jKWiE4u6hrP5G8KhfiOKcQj/Nfy9P0?=
 =?us-ascii?Q?WyniTKVhHsuNZJQuR5zdY3lx2t7DBSlomasAZ1Moen2X6+GerOEQqeVvwFpm?=
 =?us-ascii?Q?jZGhS1bCG+zKUyiTQ8ELWqaUU0ykC1rGHwhaAD/+B1GZyBCALH/rpHwhKn0Q?=
 =?us-ascii?Q?w46py0gm8Y+uexKyWPa18SrMGncjKbcviWu70zecVDcN9TkoyMiLCahqN/2b?=
 =?us-ascii?Q?0hEiFbJ9zNvrwY1T7L+0WlXUFeWCYXose3lKwdwQZORA1q/OV2RJ0X0K6zCR?=
 =?us-ascii?Q?WkUuzwNcYpo4lwuWBgJW+a9kFX6E5VQOZ/csvL3vWu77pjp6MY94iztShEmP?=
 =?us-ascii?Q?yg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50305e05-58ef-4943-d49f-08da9f873025
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 06:20:20.2908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yVQnqZRrWD8Db0+G+LzKvDDi1MwRJKn3uW+fFVv/l/3yUcBjDJsg3FA5lThoPGAf0kGNAO8LfF4Xt5ZRyWeK5hLUG+gKFsMyLcyKU27VDyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5544
X-Proofpoint-ORIG-GUID: eBeLOGd39ykjdJE5ks02-Te3J7XvPyiT
X-Proofpoint-GUID: ChCc6Z97m5o2vqPBElK3zihTn7qN01Rb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_04,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 phishscore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260038
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, September 24, 2022 7:54 PM
> To: Wei Yongjun <weiyongjun@huaweicloud.com>
> Cc: linux-iio@vger.kernel.org; Wei Yongjun <weiyongjun1@huawei.com>;
> Miclaus, Antoniu <Antoniu.Miclaus@analog.com>; Lars-Peter Clausen
> <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>
> Subject: Re: [PATCH] iio: filter: admv8818: fix out-of-bounds read in
> __admv8818_read_[h|l]pf_freq()
>=20
> [External]
>=20
> On Thu, 22 Sep 2022 11:58:48 +0000
> Wei Yongjun <weiyongjun@huaweicloud.com> wrote:
>=20
> > From: Wei Yongjun <weiyongjun1@huawei.com>
> >
> > ADMV8818_SW_IN_WR0_MSK and ADMV8818_SW_OUT_WR0_MSK have 3
> bits,
> > which means a length of 8, but freq_range_hpf and freq_range_lpf
> > array size is 4, may end up reading 4 elements beyond the end of
> > those arrays.
> >
> > Fix to check value first before access freq_range_hpf and
> > freq_range_lpf.
> >
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
>=20
> The datasheet isn't clear on whether the register simply can't take value=
s
> above b100 or that the behaviour if it does is undefined.  It would take =
someone
> to poke the registers on a real device to find out.  Either way, this see=
ms to
> be a reasonable hardening against corrupt data back from the device.
>=20
> I will leave it on list a while longer though so it is probably 6.2 mater=
ial
> now.
>=20
> Thanks,
>=20
> Jonathan
>=20
> > ---
> >  drivers/iio/filter/admv8818.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv881=
8.c
> > index 68de45fe21b4..fe8d46cb7f1d 100644
> > --- a/drivers/iio/filter/admv8818.c
> > +++ b/drivers/iio/filter/admv8818.c
> > @@ -265,7 +265,7 @@ static int __admv8818_read_hpf_freq(struct
> admv8818_state *st, u64 *hpf_freq)
> >  		return ret;
> >
> >  	hpf_band =3D FIELD_GET(ADMV8818_SW_IN_WR0_MSK, data);
> > -	if (!hpf_band) {
> > +	if (!hpf_band || hpf_band > 4) {
> >  		*hpf_freq =3D 0;
> >  		return ret;
> >  	}
> > @@ -303,7 +303,7 @@ static int __admv8818_read_lpf_freq(struct
> admv8818_state *st, u64 *lpf_freq)
> >  		return ret;
> >
> >  	lpf_band =3D FIELD_GET(ADMV8818_SW_OUT_WR0_MSK, data);
> > -	if (!lpf_band) {
> > +	if (!lpf_band || lpf_band > 4) {
> >  		*lpf_freq =3D 0;
> >  		return ret;
> >  	}

