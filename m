Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 311015772A
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2019 02:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbfF0AnW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 26 Jun 2019 20:43:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:11270 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729871AbfF0AnW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Jun 2019 20:43:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 17:43:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,421,1557212400"; 
   d="scan'208";a="360515306"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jun 2019 17:43:20 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 26 Jun 2019 17:43:20 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 26 Jun 2019 17:43:19 -0700
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 26 Jun 2019 17:43:19 -0700
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.83]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.72]) with mapi id 14.03.0439.000;
 Thu, 27 Jun 2019 08:43:18 +0800
From:   "Song, Hongyan" <hongyan.song@intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Xu, Even" <even.xu@intel.com>
Subject: RE: [PATCH v3] hid: remove NO_D3 flag when remove driver
Thread-Topic: [PATCH v3] hid: remove NO_D3 flag when remove driver
Thread-Index: AQHVGNiSNbVdT14cSEyAQBwUe1GZ/qatd40AgAA4r4CAAGX8AIAAuinA
Date:   Thu, 27 Jun 2019 00:43:18 +0000
Message-ID: <AE3E3DFA698D6144A7445C92D1D41E2F10D92AD8@SHSMSX103.ccr.corp.intel.com>
References: <1559434641-11783-1-git-send-email-hongyan.song@intel.com>
  <nycvar.YFH.7.76.1906261406120.27227@cbobk.fhfr.pm>
 <67a1ec6dd44866c29333f5b05184cc402bc20382.camel@linux.intel.com>
 <nycvar.YFH.7.76.1906262334161.27227@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1906262334161.27227@cbobk.fhfr.pm>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2YyYmQyZWYtZDJlMy00NTM1LThhZjEtYzA4MjlkZmFmMjBiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRTRYRVp3WDZac2dkemFrUFF1YUIzZjJsNXhpakpZK3lLK1l4OGVqWXhpSDk5ZzJcL1d1andyZjhnNmZoS3FFbGQifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,
Thanks Jiri& Srinivas for the merge schedule information.

BR
Hongyan
-----Original Message-----
From: Jiri Kosina [mailto:jikos@kernel.org] 
Sent: Thursday, June 27, 2019 5:35 AM
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Song, Hongyan <hongyan.song@intel.com>; linux-input@vger.kernel.org; linux-iio@vger.kernel.org; hdegoede@redhat.com; jic23@kernel.org; Xu, Even <even.xu@intel.com>
Subject: Re: [PATCH v3] hid: remove NO_D3 flag when remove driver

On Wed, 26 Jun 2019, Srinivas Pandruvada wrote:

> > Srinivas, I'd prefer changes like this to go to Linus tree in merge 
> > window and not -rc phase, so I'll do that unless you tell me there 
> > is a good reason to push it to Linus still in -rc.
> Correct. I will tell you if it is important enough to go to -rc 
> release, otherwise all changes you can assume for the next merge 
> window.

Thanks for your confirmation. Now queued in for-5.3/ish.

--
Jiri Kosina
SUSE Labs

