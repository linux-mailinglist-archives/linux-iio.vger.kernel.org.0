Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9331454F11A
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jun 2022 08:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiFQGhU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jun 2022 02:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiFQGhU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jun 2022 02:37:20 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC4F55378
        for <linux-iio@vger.kernel.org>; Thu, 16 Jun 2022 23:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655447839; x=1686983839;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=U8HrwFWBTyTUn8Ml8L5B+gdlm+NlucAHTy0EsC+5C0M=;
  b=M3vnX6PdbCKzjqBqCiYmsIaqk61cJB+oV6ZjGfc3LecSIgtWiBsCH5Bu
   qpSwwxZDjKPs7ciDbjiPl3xIM7sJia4zfUXHDtREL/H1MVBbe+Lx+VQTC
   u3SjzqVm12+Ia30EXt4Tzu4Cs75gxO7Ygf0YQTfMsWD7IQ2YioVcETUeR
   WSFd9HtoEnwCh6nhQ0j1fCgneWX8Ld8GYHDK/C863TVu/YJp6U7HMH4xG
   /9Kut5ciewpZAeI57v/CaKU90Ogy2dTlZlfxpdN63/QCIoCD/zH5Te9AZ
   xBgAmyGd0g/BGJwj6nMxOnIkJcV2sA2lcp58PAI4Zk62ekKUtbOfKLhJp
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="279492301"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="279492301"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 23:37:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="912492084"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jun 2022 23:37:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 16 Jun 2022 23:37:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 16 Jun 2022 23:37:16 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 16 Jun 2022 23:37:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6pe3Gc4kBLINtiCjfmsLBZCC8mkkxxumQ7pLp5iMLtM2Br7v+SVWwhN6nfr3fsCvUeJcoNXlpTAdRfpAf/GoTbYZ97539YrLPYvUvUULZ+Gd2ocSHWj57h3a0JSP6kG6uWhjL35L+wRC68W76jJ5KQ5WMvV3jGEwSk8R5aLyZMm8LdVAr+2ABv+/UDLb3erPyd1fQk8S+R+tFk7mExEW7kjYW0jZ6BTmL/cVQM/3WedAyD/xIGhEVVt0jXJOVAvGoBtKpRF864fKc/TclNTLgH7IrRyjLwrqVyTZgFwnMopaYyaEsf3vKFBOGlbc5TSqy2+SHsBeywvZqlFHNUxPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8HrwFWBTyTUn8Ml8L5B+gdlm+NlucAHTy0EsC+5C0M=;
 b=G0psSOvSmizzTGCYj6Iu8FgYvim0/Via76CiH6tzhY5CrEk9r0yfe7Khv6OMRXcE1HXe1qlFRqSTQvqcb5aZOhb8s9KiNNX3LRJVTVf43faSnlzaCY9YNOTdBhZhjndNXuVsrFlzQGXEpoTgu8rtulr3b4aoowgvizviha0/uW0PYa7L6M4nZth2aWoKatgOemgLIx4hmkfgcPDNeDML1Rh5PJik1N+uN120bkIrVxPJ8Lrkq2AyYIUN0H39BQpIELRtTAWUmNbg8A/A/j1YKPA0dNP81DPNMmUBdhdnwJqU7qzHm0Pr7QCQF/9FxXeQkjFnqDKo7Dpu7EdwBWLQQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3240.namprd11.prod.outlook.com (2603:10b6:a03:18::19)
 by SN6PR11MB3469.namprd11.prod.outlook.com (2603:10b6:805:bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 06:37:14 +0000
Received: from BYAPR11MB3240.namprd11.prod.outlook.com
 ([fe80::918f:c6e:164d:3216]) by BYAPR11MB3240.namprd11.prod.outlook.com
 ([fe80::918f:c6e:164d:3216%5]) with mapi id 15.20.5332.023; Fri, 17 Jun 2022
 06:37:14 +0000
From:   "N, Pandith" <pandith.n@intel.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "vilhelm.gray@gmail.com" <vilhelm.gray@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>
Subject: Intel Timed-IO driver in IIO/Counter subsystem
Thread-Topic: Intel Timed-IO driver in IIO/Counter subsystem
Thread-Index: AdiCFGKgSJf28KGeQ2qEKrwEQy9pwA==
Date:   Fri, 17 Jun 2022 06:37:14 +0000
Message-ID: <BYAPR11MB3240148739EBB945211DD77BE1AF9@BYAPR11MB3240.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3d5d269-d029-46d4-ad26-08da502bd0ca
x-ms-traffictypediagnostic: SN6PR11MB3469:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR11MB34691F9E67BE4837B048B3D1E1AF9@SN6PR11MB3469.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cc2ux7Ko14z//bXtSRY8GmZ1pBKSrX2WY+UvqJhFFAHZA2KiXPMDoneCBLQFmTc997Sr80BD4FKjIKrdygeekVh/cCX6EK0TmCqkGR91z3FEjZgKl3Pfvm5Y9KdbRjyR5GBkJGcqNT0Gg+/HX23bftSrRc+MOsyGbHyx224iuqE97mCdMiNfHOfJzCkUthXMk2k9iDM+5KfrxFTazsdEwuJ4s8u64coEMLbkKdzIa4JjZHDQpCnpBWv2l48MKRHMe7lVTmPuRP5M6EbjJTmUh1gV9mNg5HpKAZYh8AYN5BXouLJ9fjksYsDticMFdALRaHlWyPjGaGtzVwniCTz0mX8DCxJFl4YB/buW/mS8lwfzvTqRhT/4LAWqSG61mhx4Rt6oZq+IcOEkMvu/YTcT/KLxRYaJ9LiR/gc/HjmZc6yi+qw1Bjv4SLBb2Qat3611449kp09PG3oECM2JUD8/vTrG65hy9RGmPsjzZrGuCd6DyL/JkbzldQYZTfC+D46ZGFssWurIWFeXdrmuOC44doqRzbhZ2PoAZozTsQGfoQfe9km4mkCOTmyZ9w3+1UMnfLo2h34qI+961q+zVSKw53oh8wYdQoiPk1SiWZmD7lsCOHp6PCYxeq3/IqZqP8XzCwX3bNwmeMRZpdHCeOk0wfQACbYOkRptof/fJY2vJGcAf7DTqHpaXhmRt2aEnCqEdpPKCSCKTImByUC5+a/TgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3240.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(33656002)(55016003)(4326008)(8936002)(52536014)(4744005)(5660300002)(316002)(64756008)(38070700005)(71200400001)(8676002)(508600001)(76116006)(66946007)(2906002)(6916009)(54906003)(107886003)(26005)(9686003)(66446008)(66476007)(66556008)(6506007)(7696005)(82960400001)(186003)(83380400001)(122000001)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xv6Y339EPBr8dPn5Puez1ddV0MOQZJDXxHfSUbcGaeT0/Qq0bR2x0wFZWW+C?=
 =?us-ascii?Q?r5crYdH6XglXYaQi67WQxO2fYLga9XBG93p36h5qYQqt3b9DG4Ua51wonyQO?=
 =?us-ascii?Q?qO8RDFaTZbrqcMuDOq5YbmD71gE6R4DzTUYN4wAmFFrRvzlLvXn3VIIiGB+K?=
 =?us-ascii?Q?ujJuHFcdOFF5eSk9Hx53+XdSHYTFggYICGyKxBhMh2nd7Sh0iLDcUCdH92um?=
 =?us-ascii?Q?dsPaX9QsSotZHpbsq+prDXmErmm3K3WiDPGVFhrP3anQ2T+16kdmsMX2Mh0k?=
 =?us-ascii?Q?bUClb7s53ZcrpkeW/LjBOik9y24zQM8Hq+tpjyuHiGRK5vl+teq8W8a0cD3M?=
 =?us-ascii?Q?QIr0ORb/OXIJnjxzZft8kUmXnMJoAW+qSpuC7LD7pIP5hxa5OykZolcEc66P?=
 =?us-ascii?Q?4q58loo+IUkRsVO36+lcv/2DYyQcAyr36NnyuglGar1+3lFGwKCi6oN7byMh?=
 =?us-ascii?Q?YcRCVbF4HHxIdkWXBH3HvzuVTWa+eVGc9oxxYie8ko03zQ3CKdu1zC8YKVaL?=
 =?us-ascii?Q?XO49q8Q9WrJMBJMpHw5jAlPUE8anfuidHCFVn8K3VjQ+kuNK/G+8q0PAdiFd?=
 =?us-ascii?Q?DgGXSpa+MNy3fBjFwKSqeLQXm6M1awx6iGxmKloK9EwqU3TX26oXm6S9kKlz?=
 =?us-ascii?Q?yh6Xpqjam0QLrA2luL8SCnL3eOer7y6Bbkx9RLRYmZkPnSE8rVmWuBIFZ2Bz?=
 =?us-ascii?Q?3DPLr8zmbs+Z/Xz7bWLNZLXsXVNOijiFLxfrYuqTluQ/lcTz+m1Yo6UCUFLz?=
 =?us-ascii?Q?mzzs9GlgkzzxR2lHmdPIGik3zOibR3eoxht9R4CepU7i11AUoiG5ATHK3Ssw?=
 =?us-ascii?Q?I+GiEYQdoTkTV8CmB/MYgNWXY6RUGAwUSAlxnLuDqKBe3UG1rWhY8ukVbFNY?=
 =?us-ascii?Q?N1MRQYWtiwY0XzjPrwG/+jt30IL0NLf5SRyTZnpJza6TJPJmzWyruBEQCy77?=
 =?us-ascii?Q?AM5BQ3DWW67Hz3D5HOQHvyDHsKOAH0QPKkTwicCZ+kQO1vTPlhiEaN/zhVb6?=
 =?us-ascii?Q?twGmrzlOWMCTO22cR3uHUtgm+VPffhjg40EyjfAW0wuDljCkdTH0iGc4kFSX?=
 =?us-ascii?Q?4kdhbchhdr6twuSWXgT6tZ5Bv6VMpq24lw2rmRB2k4vbH8M8JHJvW8vS+nr4?=
 =?us-ascii?Q?tSFL6pywPZDkvf+BUSrpQBfOuyiHTR8+dg2mVKKoQPKVsltsJHrSJtR+Awsb?=
 =?us-ascii?Q?/Pjo6ShR4EIBh/IOjRQZtiW6Zvz9B2idBpwxQGj7F6194QztbsswVF8Pc0rg?=
 =?us-ascii?Q?RkOQaKRmXyaU3jV2g0ON9EGZQXfVRB7umeVmXEz7Muc/AxGjvci7uBfzDKc7?=
 =?us-ascii?Q?XQhRScuTP2l6K2eVHPW59SO3jO6jL88Yl2RuRLTCyejdINgyXKTC6gbAo/F5?=
 =?us-ascii?Q?zzLPIE5x0a53Uh7rG9f9AdzdbdxffP5uSd9Y6bU8oT5hYpb3Up9E/GwcsQ+0?=
 =?us-ascii?Q?mzipJ7BsEB8JqWoyqYHzIGEZkmAJEJPwFZg/jh1qjgg2DzcqE0ImQLdBBKhe?=
 =?us-ascii?Q?6yjehecA/tZp+/luPzj1a+jAVbax+J8pBS2xm3ybRBwrLefI18ap98sNPLWJ?=
 =?us-ascii?Q?6Kug2PKD3VRJWAvZdR+chd5cx60DzoYrS7+Ch3S3rC6qMkkg2QSoN3GakOkI?=
 =?us-ascii?Q?ix42vzE+ZzZt6ZivEN9H+sMhI1NTjY2Xx0fl/kOvWO/ZinTAvWu5v2xjCLAO?=
 =?us-ascii?Q?BRHQIBcXqtc9BlRNl0/SJenIZ8xZKqnArIX6LqXOKCu+bqBXz68x9cS2r87V?=
 =?us-ascii?Q?fZhXi6aH0g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3240.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d5d269-d029-46d4-ad26-08da502bd0ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 06:37:14.2949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5nQicJWGUl7bRtDzpqmPyQdxEKBvyrDTA9LvPrFj8Jb64FcguoWTz+rcFPTm7C1nyRRsrPPIgjGVhJlYCCJmNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3469
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

We have a Intel Timed IO peripheral with following functionalities :

1. Event capture capability - Captures event count and timestamp.
2. Pulse generation - periodic or single event generation.
3. Return cross-timestamp on request.

Timed IO device is being used in various Industrial use cases such as : tim=
e capture, synchronization, fan speed calculation etc.

IIO or counter subsystem seems to be suitable for timed-io driver.

Is it favourable to implement as part of IIO or counter subsystem ? Wanted =
to know your feedback.

We may need to use custom ABI for sysfs based user interaction OR
Can we enhance ioctl interface to accommodate our use case (counter-chardev=
.c) ?
Since timed-io works in nano second precision, ioctl is more suitable.

Regards,
Pandith and Sowjanya

ps : resent the mail with plain text as delivery to linux-iio@vger.kernel.o=
rg failed.
