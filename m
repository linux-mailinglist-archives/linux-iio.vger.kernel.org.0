Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231BB4A364B
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 13:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245066AbiA3Mjp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 07:39:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58980 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240805AbiA3Mjo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 07:39:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED5B3B80DE4;
        Sun, 30 Jan 2022 12:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CB5C340E4;
        Sun, 30 Jan 2022 12:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643546381;
        bh=CCjMch+EUmAZfUmn7YMzwEFlRI9krRM19G03S8jDpeE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ml5ctTiyE2lQeT+deZMjTojb/7iwZ/92VZ5TjXgP+8jDFad9BdPut9P4/umVczP1u
         rCTjqQaNBlFDQ6AZiheWhS3qFeoYkQaAtSLv60yjSfehlpbxFFAedcPbA88jOUtFOA
         GcyhD25dXwf4wQ3O9/NjQ0ubiGKliE6Dg5Yi0KtExEjbPMUea073ux+IHkweNQNTja
         16e1adPuWedXtwwvm/haQdv6WLTrKEntRm3TBduZrdQ3QN+23Tn/RrKVNChcojkrVM
         0jqhZGTTeWUbzzQF+K/9ggNLqDfU2VarR5CLMR3X+XhZlRf85JqUAczEiE1zQ42p0N
         oUv9oyzv5MUiw==
Date:   Sun, 30 Jan 2022 12:46:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Robert Hancock <robert.hancock@calian.com>
Cc:     linux-iio@vger.kernel.org, anand.ashok.dumbre@xilinx.com,
        lars@metafoo.de, robh+dt@kernel.org, michal.simek@xilinx.com,
        manish.narani@xilinx.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Xilinx AMS fixes
Message-ID: <20220130124605.6268bfc5@jic23-huawei>
In-Reply-To: <20220127173450.3684318-1-robert.hancock@calian.com>
References: <20220127173450.3684318-1-robert.hancock@calian.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 27 Jan 2022 11:34:46 -0600
Robert Hancock <robert.hancock@calian.com> wrote:

> Various fixes for the Xilinx AMS driver.
> 
> Changes since v1:
> -drop addition to ZynqMP device tree, will be submitted elsewhere
> -add patch to fix DT binding to add missing clock entry

I'm fine with these but would like to leave them all on list a tiny
bit longer so we can hopefully get some review, particularly on patches
1 and 4.

Jonathan

> 
> Robert Hancock (4):
>   dt-bindings: iio: adc: zynqmp_ams: Add clock entry
>   iio: adc: xilinx-ams: Fixed missing PS channels
>   iio: adc: xilinx-ams: Fixed wrong sequencer register settings
>   iio: adc: xilinx-ams: Fix single channel switching sequence
> 
>  .../bindings/iio/adc/xlnx,zynqmp-ams.yaml         |  8 ++++++++
>  drivers/iio/adc/xilinx-ams.c                      | 15 +++++++++++----
>  2 files changed, 19 insertions(+), 4 deletions(-)
> 

