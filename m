Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50BD55D010
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 15:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238105AbiF0Usl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jun 2022 16:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240640AbiF0Usj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2022 16:48:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AE06578
        for <linux-iio@vger.kernel.org>; Mon, 27 Jun 2022 13:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656362916; x=1687898916;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GEb0eWvSJFxUtFywpdUaI/n4TJijl/dzlLx9bimJDRE=;
  b=fwDD22Bmc5IdXIKU7hZPPMKtKxuruM+5TbALTylErctqQqN1FwRMTpuL
   e55hmaVBcp2RZaGE0GiWaVqK0W4GkmxkxyEPu96EG9smylyaFmAGapEy4
   5jE+sgLCi0iXVZL6t+3kgy5FBxxhIlF7xn6qSzAiMJsFcmQd/uW8FMTo7
   uOdgnvk4y+StHjBwVyNPRA+JltrakDWgmhi8FVoVIWW9TO6UfmlaMpoA2
   hTCStv6jcUf8ZCBdggk9kiw+SPB/ixrNVwqeVW3smojZga58bRk1CmAgE
   YMiqvZDduhW/WkCfaNeQ83od39UlHm5pJ89vnUKh5803gkI6vu60bgg6Z
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="270305117"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="270305117"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 13:48:35 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="590054117"
Received: from gfgerman-mobl1.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.31.245])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 13:48:35 -0700
Message-ID: <6f7db3330838b08f5d83c9493a5ccfe25fbab468.camel@linux.intel.com>
Subject: Re: [PATCH] iio/hid: Add mount_matrix
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Gwendal Grignou <gwendal@chromium.org>,
        Bastien Nocera <hadess@hadess.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>, jikos@kernel.org,
        wpsmith@google.com, linux-iio@vger.kernel.org
Date:   Mon, 27 Jun 2022 13:48:35 -0700
In-Reply-To: <CAPUE2usZS2ww6r67kppn-4WGR7h++c6ioRu-A-ag=h7DpaVSYA@mail.gmail.com>
References: <20220624223341.2625231-1-gwendal@chromium.org>
         <20220625120937.24c51ca4@jic23-huawei>
         <937c3317-91f7-9236-70a8-39ca4c2f6396@redhat.com>
         <534cde0d461b194e2fa9a91bd987da1cd2aae58a.camel@linux.intel.com>
         <CAPUE2usnMyDN5DpgY_dtj73Jb811-9Y6Q8ZLsnqKiA7=q=74UQ@mail.gmail.com>
         <60f39446-a764-2f7f-ec6c-30f49ada3f07@redhat.com>
         <CAPUE2uv-GS2ZMhmzmLzHhUGyrtDJ0GVvk17JafnMSSYdnK8z0g@mail.gmail.com>
         <b0b9beb8440ca40e6673b1ee8473708516d639cb.camel@hadess.net>
         <CAPUE2usZS2ww6r67kppn-4WGR7h++c6ioRu-A-ag=h7DpaVSYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2022-06-27 at 13:23 -0700, Gwendal Grignou wrote:
> On Mon, Jun 27, 2022 at 2:55 AM Bastien Nocera <hadess@hadess.net>
> wrote:
> > 
> 
[...]

> Relying on a quirk file for all standalone sensors is not sustainable
> IMHO. I agree changing existing output in newer kernels is also very
> difficult.
> Should we add a new iio sysfs attribute to indicate the sensors
> report
> data according to either the W3C specification or HID specification?
> If present, and set to W3C, iio-sensor-proxy would invert the axis
> first before applying [new] rotation matrices which will never change
> the basis.

When we added support for HID sensor hub, it was primarily driven for
supporting Linux on systems sold with Windows. This started from USB
external hubs to i2c external hubs to now ISH. Still they all are
designed for Windows primarily as OEMs will test on Windows and will
have to pass Windows compliance tests.

We can export the following fields to user space to do any model
specific quirks:

From HID spec:

Property: Sensor Manufacturer
Property: Sensor Model
Property: Sensor Serial Number
Property: Sensor Description
Property: Sensor Connection Type
Connection Type: PC Integrated
Connection Type: PC Attached
Connection Type: PC External
Property: Sensor Device Path
Property: Hardware Revision
Property: Firmware Version
Property: Release Date

Thanks,
Srinivas

