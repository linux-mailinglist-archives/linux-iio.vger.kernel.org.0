Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3BF373B70
	for <lists+linux-iio@lfdr.de>; Wed,  5 May 2021 14:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhEEMiI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 May 2021 08:38:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233295AbhEEMiH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 5 May 2021 08:38:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D6BE613BC;
        Wed,  5 May 2021 12:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620218230;
        bh=fdtoiOO8qA6Z15EU3pkpce86bDIJDbnRKUIpVmpH880=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=IXgiXhy6NOI2gMa6vixpLEtJSHF4czwOYOHahqaiFyQA6bJfskwv1X4ykyeC0eI2M
         IDs2vu/QZK7pJ5lC1NuTRUptPrcvTKH6Y0dyjs7/CPLUmTE2UMwN4IbQvZjKVT0eeS
         KR/gRG7wxxTpxY+CVSpIXZv04o4fa3mgPIhea4WcCMNWVxxd7Tw4uhBnrsBHMhP8c/
         9HJgBYwDEtReiCYEsRBbwSmW7Tlyj1aBrmWCo+iGfz2D4QqNY92EjQcPoG38pE87Fj
         6bC/i+4Ad03gh4wdlZXWccntL223HbBbtnm96DDiiF3XHrViyCt5d5+VC52ImSJvr5
         7XCG8wtTdwySA==
Date:   Wed, 5 May 2021 14:37:07 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     jic23@kernel.org, benjamin.tissoires@redhat.com,
        jiapeng.chong@linux.alibaba.com, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: hid-sensor-hub: Return error for hid_set_field()
 failure
In-Reply-To: <20210415185232.2617398-1-srinivas.pandruvada@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.2105051436580.28378@cbobk.fhfr.pm>
References: <20210415185232.2617398-1-srinivas.pandruvada@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 15 Apr 2021, Srinivas Pandruvada wrote:

> In the function sensor_hub_set_feature(), return error when hid_set_field()
> fails.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied this one, thanks.

-- 
Jiri Kosina
SUSE Labs

