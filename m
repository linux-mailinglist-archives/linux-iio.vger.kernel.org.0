Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5873054F117
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jun 2022 08:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiFQGd5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jun 2022 02:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbiFQGd4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jun 2022 02:33:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0497855377
        for <linux-iio@vger.kernel.org>; Thu, 16 Jun 2022 23:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655447635; x=1686983635;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=KU7eEWipSDFfrGEVn1GhGZ7gZWy5d9ZufyQ2XI1p/aI=;
  b=LcThx+hEWXSLyIJoi7/PbcfhN/28bfhNf2caqiExg05SnJgS1Ebhh8QI
   C0n3IlqJbrczn+89atkMjhWepJBqKkRZQ6XGaMBpEFZZhvgbsClQxdERR
   TThd/oMCUIqb7VCSYMTfej3gB40FLkAPIHvinHIEoqs9GPR2kCfUNXv6q
   Up207m7OvjVMgLwERIF6oGyYZ23o4DSu/NNGTkk/m95NqAqs9YIiFofzJ
   znchiao8zCbcY0ikrNAZQxR2Kj/Vt1DO4XGHfbaLBILINOV+8Q772wKu+
   /uzYS9D5s3uoOrCclyvwdrGZfH1fm1nFilAfkth+RvBJsOwbq3DeVgiTD
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="279491803"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="279491803"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 23:33:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="536728569"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga003.jf.intel.com with ESMTP; 16 Jun 2022 23:33:40 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 16 Jun 2022 23:33:40 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 16 Jun 2022 23:33:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 16 Jun 2022 23:33:38 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 16 Jun 2022 23:33:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDkOnBzbySWm5t/eRI7r7sLUEJ6+a/JNO3GgW4SSs/sbIZI4TZBRfsrjNP/tsaRchW2M8ms3By0vkAbahynrtUeD9hZZZSLRgstsR5DXnvIebLUGwg9wIzEcd4LsUbSsf4psBX2oRkkOVP9KygPAVZ6zAb4h85CTYuxFP98nAW8F02UHzXDuJXw3jLRF+JoKyqvjwCxyQJzeI6AZwDO56qGvFc5RvNhcuRE+NUH7/lVV0nBQE32sIOAPOaWsAX91qXB7ixIZ6iCOhvFNjj2/HVU0eKgaAnGn0925RMoHTfdiO+Y1bPEzIcynmm4UQ9XFtXzq+WgaX8J0mbPGHtv7hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KU7eEWipSDFfrGEVn1GhGZ7gZWy5d9ZufyQ2XI1p/aI=;
 b=UthsiYC83kGOcFJkwt41Rlm1twQHOfvJxV8/6bWkuK1wRrwIHSOaduy+HXKNTnW+ch8AKxPgx8Xd/AMGsXySheYIQ6cjiboL7GJ/onqeDAAliP2aw+fS2cvhwy3nEMgwP2LyCVIJKrVmfGyurPNqmCGg6DrmfKckFvjKF97QitXPyy+BtkczzITEh5RfbuCyno56XFoapeuBvPmFDvhmU2sop1vWnijEMwwkrJoGY6PWk9JqoqP63bsQQAKyR9H+mZPPwlDUNt0dtG29GayS1Ch5Glc9pL8vxhx0+zhnz2sqs/p7szSCX+95Epo4fCSmTA3zvFcG5s6UH1K9y8av7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3240.namprd11.prod.outlook.com (2603:10b6:a03:18::19)
 by SN6PR11MB3469.namprd11.prod.outlook.com (2603:10b6:805:bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 06:33:34 +0000
Received: from BYAPR11MB3240.namprd11.prod.outlook.com
 ([fe80::918f:c6e:164d:3216]) by BYAPR11MB3240.namprd11.prod.outlook.com
 ([fe80::918f:c6e:164d:3216%5]) with mapi id 15.20.5332.023; Fri, 17 Jun 2022
 06:33:34 +0000
From:   "N, Pandith" <pandith.n@intel.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "vilhelm.gray@gmail.com" <vilhelm.gray@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Subject: Recall: Intel Timed-IO driver in IIO/Counter subsystem
Thread-Topic: Intel Timed-IO driver in IIO/Counter subsystem
Thread-Index: AQHYghQrH+bdsqobJkWdL5aNQqG04w==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Fri, 17 Jun 2022 06:33:34 +0000
Message-ID: <BYAPR11MB32404216BFE8A47C9852E818E1AF9@BYAPR11MB3240.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63a98188-24b4-412a-b35f-08da502b4da4
x-ms-traffictypediagnostic: SN6PR11MB3469:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR11MB34692BEC437626E05BFC4617E1AF9@SN6PR11MB3469.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RU8050Ruf5CYkSYznuLFgDZM4pgwQlpzKdHyNqN5Jlwpycvck8FUEf+HKXzhFFGAkO0FLUWhb8piBPgNY2V2sMtMnbQcdmDg5t57u8YJ07Hqcr+gdgiPpDMuDuEJ9Q/re4l7yCIbUMxsb6K/WdBD8SJehElZmEZzKLpfRYw6Tm6lF0XJs7wWHTb229OIMWkMhdvh90ieTpgpldeR3rflP45v4mCq53qRKw12lUuwhKZ1Sd2bhD1lmp05842uLGwrmQq07a0o0PGmMsi2n+V72hMtNr6Uar+mHfxIdkVdOueEedOqqxJacCADkiXdcpbQIVCbpXjVXdt5T/Y6nDreF+1lIclIgHumq7jMMf7AlW7h18UBnGJA0sTQ8WV7phDa4/HaBCSL4ywohNyo9MYq7XgTFtOvN2oFOZeRFwyE8EaIgVOYyKbRhWdsjLe4N/25XtxcFK/cKx8ZFzI2PXBmrTuBiiCVCpHR6wE1FgBd+s5ZGiqQSi4RY5U8wmroAV1pfoUec5I8teVlPab106oCv6+h4vndzy3+6aJYcSgf5e/f2S1d5wxcMs8nNmIciJ1LhtF2UV1VauPwQfe20LzSbl9DJ61peVrh1BV2wC+tpog7pmt/J31xWbL/iOfaKvj7ZdLmkZ10ABAMIaBCw4+7jH85mc/JXuYY8/lTv2pSHirJ0LVu57Ey1YjNNUFyL9V3STG09B5J+pHzJLQp7fV5+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3240.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(33656002)(55016003)(4326008)(8936002)(52536014)(5660300002)(558084003)(316002)(64756008)(38070700005)(71200400001)(8676002)(508600001)(76116006)(66946007)(2906002)(6916009)(54906003)(107886003)(26005)(9686003)(66446008)(66476007)(66556008)(6506007)(7696005)(82960400001)(186003)(83380400001)(122000001)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kCujvlD1jAMZnsrfCZ7D4c1AzwlQWY8IwFxYagyjuJFGIKa/bBIcSW/Q1DFP?=
 =?us-ascii?Q?21x/QFLYt+hiXSEJaUf1N9FosnLLH8/78H1lIE/IhdZATaz9mQj3RtcBjIM7?=
 =?us-ascii?Q?XXK7i4Ov/omPbgoxFfcdfGEQoscRLXrYcyyqe90uY7I3BNx+Y+LbeFIfWCdW?=
 =?us-ascii?Q?thmxnutmjnbDulLJ9RVH2PgBQzwwBkUeWAAUWqv2umD2mzg8ZO21E1EIixl6?=
 =?us-ascii?Q?fxCuGi0WICTE1t56w+hfgtAcbG4s2ZvXpu5gJvYPFrfb8GwisDj1Zl/VMrZz?=
 =?us-ascii?Q?+/lC/ccLO9KvkQ9o8gcy92eTQ7Vmu/ZzGRHG3c9K1FMllHtvtQgQFVtBet93?=
 =?us-ascii?Q?ICIGyBHkW70P4yXU4I9VXuez4JxqEqvWpyLVZETLJtoSTOcpcDCjD7BK81mG?=
 =?us-ascii?Q?a9zLl/YGA+EyVnBSW5RbHvc35xJKBfizDl1jujQHPVT4TYjVW1qBlzuzdoth?=
 =?us-ascii?Q?oEDozhA+wFAwWNjE2QrAITCt0kp0x25BxfjAe8++QHAmQdBF3beQUewJ5POA?=
 =?us-ascii?Q?8prI71iomIc0sUBjuw12cJsV5DpMi6cAqWusgGr4Jhg8NEd7sMCIVjOETs9M?=
 =?us-ascii?Q?lAXwW5LtDx37wzuKrYODjtFnjA8VDTINM3uorZHqGLkrWuREnGDi4lCOD9Cm?=
 =?us-ascii?Q?ugkV7Z4d0PZ/wVb/LNsQnY5kojOQulpdXE/r/OnaYe9JRk5mhpBd+tesKkt4?=
 =?us-ascii?Q?0lJO7C+LElBwRuLirFegReK7Aru343IgXcGyvN3pP8nUp2Nol3cNRCFzuvHN?=
 =?us-ascii?Q?fqRDZt0A8DG76lgljnSEcZIedw6b+BDrX3DbYW8SiG9hX782BIJD8zYjfBra?=
 =?us-ascii?Q?q8hSDtgiGPMHG778AoQb21c8s5F5nAKT0+UowLu33WF+Jk2sc9dEoCAD+2CJ?=
 =?us-ascii?Q?2XKbtlJjXjgeqd5v4dKSAXa/IBI0KbzlZ4bzS9z1+kG3Go9dIc3O8zfUHwI2?=
 =?us-ascii?Q?lOdzyJGSdfJxKV4kaN4BfHhe47+7kvRVFJGrWqnkD9T+gNs4FwiTuNcH3/A5?=
 =?us-ascii?Q?Z2geWD+qa4WHeG2Tsa2oUzl5zDs0hI1VdNuOOUiTGOBRm/9vr7290gAy2tcl?=
 =?us-ascii?Q?E0oo0g99HlHXyBe9qzhXXTKURUrF0M4hBG0/yuJOqV9J+zxztURQwjULteF/?=
 =?us-ascii?Q?0huRZ78uiErj3PTLWSkv1f4F0ZTT/D6IHl8EOOGLu/ilB6lC840TtqEOY3KH?=
 =?us-ascii?Q?KmJQP32nBLf/PuxLN9fk3/14hl1CqhzTKrA4ib4kD490F0Urr/vSqth8MooY?=
 =?us-ascii?Q?2aFSVTpjy4QyHbg26+WRIHbQjnmgBrvcDf+Po6wpNxIyan0Ultx0DKkR7771?=
 =?us-ascii?Q?mTMiM79UoJEtB/TNpw6cdQEsJyMqEHMM1tLOEP0ZTFUmyRdgowIC1B9peEuk?=
 =?us-ascii?Q?HZuAbqN8gNJKhxL5pJnDRZlYWeofAxbnicBpDFSuxWSWNiR1ZTrFMeWqRv88?=
 =?us-ascii?Q?hqN1M8BFVOK+9KJbqFGPJ/0gS+/6vmuYKOeJPsywLhF7IkVEQWEfdNKaRFUD?=
 =?us-ascii?Q?Dp7aWQpC7EAkHCgmZAQ81VCcnlExixVtLYoXKjdfVZY7hnwbu69sAcVdoHSQ?=
 =?us-ascii?Q?odwux/qbXB1VFnjOVEa8LxdlbEPEn/qwY8kpQya1joaprKMmwkggSMZMAbTq?=
 =?us-ascii?Q?khJUmBCujAZG/l+faFvHl/FBgP0R512J7y1RCsEBArIGWE0uFEEVTS2L/6D1?=
 =?us-ascii?Q?vpPFErFlf5qLed/CE9avyRBboKUSo/LDNEYLcGSma74HAbnMvAVTl8vibLvo?=
 =?us-ascii?Q?XDoF0F0K5g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3240.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a98188-24b4-412a-b35f-08da502b4da4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 06:33:34.2176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 03Jq9BVGKYreJ/G8m00NBf1AYzG/YZ+N+6GHoOxk6BRm9QDFlds2wqyEG9oqObewp133p83YVnAestHAGwWaig==
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

N, Pandith would like to recall the message, "Intel Timed-IO driver in IIO/=
Counter subsystem".=
