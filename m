Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97D57C97BD
	for <lists+linux-iio@lfdr.de>; Sun, 15 Oct 2023 04:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjJOC4c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Oct 2023 22:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjJOC4b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Oct 2023 22:56:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE68D9
        for <linux-iio@vger.kernel.org>; Sat, 14 Oct 2023 19:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697338589; x=1728874589;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=QZkf+OM8K0YESB41mk/+wCfn/XJMCjU0YOytpvqc5xI=;
  b=WbHdYL7KANqqxvNgalqPTa9gHbtNX/XatAOCIjArTcj0pEwJEFCQegbV
   Xrbr4uRxwAtGbHiUrC2fhPXYlw+d3h8+dQdTK1mzkr4DXOsXVRTv4E8fR
   RGGyTHGeK/8cxJ3FDtGqAAdsweR2dWpueb/T9AxfzauNAHJSYU/9c0AtT
   W69y6dC+wJf6CndP+wu3WD6ft5Iz7KxrLP0w71+VC3YLWISXVKOoEjiGa
   /TfjSSCZTlxAaSnLl9WrpyFSfu6Z5YdJeeWBepq+mK9XKZPAhhoPxdSIG
   /JOcBng4h7q0Cvj7nDnrbyGRyeNTXhFLAA0ln8cYxpNB3XvowpVW0pQUZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="451839085"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="451839085"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2023 19:56:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="1086637477"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="1086637477"
Received: from spandruv-desk1.amr.corp.intel.com ([10.209.44.213])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2023 19:56:27 -0700
Message-ID: <32200d0651ba77d03bad5733d8690f9f1b7b8d1a.camel@linux.intel.com>
Subject: Re: [PATCH] IIO: hid-sensor-prox: add missing scale attribute
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Philipp Jungkamp <p.jungkamp@gmx.net>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Date:   Sat, 14 Oct 2023 19:56:26 -0700
In-Reply-To: <20231014175206.6b2ff811@jic23-huawei>
References: <20230806130558.89812-2-p.jungkamp@gmx.net>
         <cd33e36768322d4e8f7919711d3474f57c4383ff.camel@linux.intel.com>
         <trinity-2e8c2d00-be4a-4590-ae0f-265289d9256b-1691497330952@3c-app-gmx-bs40>
         <20231014175206.6b2ff811@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2023-10-14 at 17:52 +0100, Jonathan Cameron wrote:
> On Tue, 8 Aug 2023 14:22:10 +0200
> Philipp Jungkamp <p.jungkamp@gmx.net> wrote:
>=20
> > > > The hid-sensor-prox returned an empty string on sysfs
> > > > in_proximity_scale
> > > > read. This is due to the the driver's scale never being
> > > > initialized.=C2=A0=20
> > >=20
> > > What is scale value reporting here? Is it 1.
> > >=20
> > > Thanks,
> > > Srinivas=C2=A0=20
> >=20
> > Calling `read` on the sysfs file `in_proximity_scale` returns 0,
> > thus an empty string.
> > Adding the hid_format_scale call makes that a '1.000000'.
> >=20
> > Regards,
> > Philipp
>=20
> Srinivas - I was kind of waiting for a reply to say if you are happy
> with the explanation.
> All good?
All good.

Acked-by: Srinivas Pandruvada<srinivas.pandruvada@linux.intel.com>

>=20
> Phillipp - this sounds like a fix to me.=C2=A0 Fixes tag?
>=20
> Thanks,
>=20
> Jonathan

