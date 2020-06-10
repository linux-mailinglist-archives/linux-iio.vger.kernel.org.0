Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71DB41F585F
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jun 2020 17:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgFJPyZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Jun 2020 11:54:25 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:33386 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbgFJPyZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jun 2020 11:54:25 -0400
Received: by isilmar-4.linta.de (Postfix, from userid 10654)
        id 53EB620051F; Wed, 10 Jun 2020 15:54:23 +0000 (UTC)
Date:   Wed, 10 Jun 2020 17:54:22 +0200
From:   Hendrik Hoeth <hendrik.hoeth@air-avionics.com>
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: BME-280 humidity over-/underflow
Message-ID: <20200610155422.GU2681@linta.de>
References: <20200610134507.GT2681@linta.de>
 <20200610152650.GA8925@arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610152650.GA8925@arch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Tomasz,

On Wed, 10 Jun 2020, Tomasz Duszynski <tomasz.duszynski@octakon.com> wrote:

> Seems this particular issue has been already fixed here:
> dee2dabc0e4115b80945fe2c91603e634f4b4686 iio: bmp280: fix compensation of humidity

Thanks, I hadn't seen that (I only checked stable).

Best regards, and sorry for the noise,

   Hendrik

