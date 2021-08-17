Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA14A3EF118
	for <lists+linux-iio@lfdr.de>; Tue, 17 Aug 2021 19:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhHQRuR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Aug 2021 13:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231440AbhHQRuH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Aug 2021 13:50:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE9D960FD7;
        Tue, 17 Aug 2021 17:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629222574;
        bh=0XDzvNvc1Od4WuvkTOZtB5DAqEjuSpfNtspOLYtG74M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QYl2GUhjpNDq3wyvcXqjvXF6tjBlSMgBWM4VSVINP9nhbvu/HZGwdrO5aW9Iyyqm5
         rQzkjBDBtVNuTFfuNj0dxZGk4aU2EgsWoI+2eVjaBpO8KNDlkCqUuS4EW5B1EefmLb
         RjP/dN9+g4Gdx8cMUGUMyZb9Dd/C7+1ZSF5DgwZ4=
Date:   Tue, 17 Aug 2021 19:49:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 2nd set of new IIO device support, cleanups and fixes for
 the 5.15 cycle.
Message-ID: <YRv2nh1L6kS3mJ8O@kroah.com>
References: <20210817161258.2e015e20@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817161258.2e015e20@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 17, 2021 at 04:12:58PM +0100, Jonathan Cameron wrote:
> The following changes since commit f805ef1ce5d695c260986fdf2e28f5d6c98cf3a8:
> 
>   Merge tag 'iio-for-5.15a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2021-08-15 08:32:07 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.15b

Pulled and pushed out, thanks.

greg k-h
