Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B891FBD9AE
	for <lists+linux-iio@lfdr.de>; Wed, 25 Sep 2019 10:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634043AbfIYISn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Sep 2019 04:18:43 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:36254 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634040AbfIYISn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Sep 2019 04:18:43 -0400
Received: by mail-pf1-f180.google.com with SMTP id y22so2944319pfr.3;
        Wed, 25 Sep 2019 01:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MBIv4exBMsbFSU5ZS4hQ7aZv5Y8krcLJtoEmNe+3N4A=;
        b=NJcpkrKl3GW6YHN9/inzdAa5eQvIAG4CgUP37EjpPaxhz/NWcnjzqhxcPXB2lHoqVN
         7KEzy7w8+WYf8jobfIXPiewuppcLUjHBm6rWtb8u3abR/sPacZLIdrxKAGti0C82NqvA
         zebEGOT7W6tmw863P75ccsQgwQMR5tt+VQbjtC3b5+qoOt+2HpCVVl0v99MtLliYWpg9
         70wfP0J+Nd5oTec7dKzTsnvfXODIviXd25SXABfrVRXGFilBLtR/aOT1DPjm3PGczStv
         23feoeCzP4Dba5qAE4tBuZbgWk6mNMw4Q2bBlizjb65YCfIXr29nbS+qlJ5g9UWWty9y
         gEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MBIv4exBMsbFSU5ZS4hQ7aZv5Y8krcLJtoEmNe+3N4A=;
        b=YFCgiI33xxNX4JbPGi1+pmYky93xVipc8oG26OuZRkNcJEVPJCNcvx8q8vJduHnIUJ
         fu/K16x1duaafO6sn7MhY/Tf6qjGRdITwOmPR0QfE2dY2fiDDvcAoc5Yc2gzxBXVKgwR
         hpuuhJGMyIxdqWrfdqBkjyrY55m9Sd8VA4KwZPsa1LwKIpyEL5ZfM+VvYXonh0gnSdVs
         YPXNYghvpHCQ85BdnC9F/KC8qehmQ/Lr91eUWrdWRJ7uyJiB+WrH8vOPmjuVh6BIQBL7
         QBnOySPxJvEuAXADTaHi2GVNyLHwQlLgRLyRvHlk856qpvEcrVs1j1YbgNdkiuERt/DU
         rUGg==
X-Gm-Message-State: APjAAAXC8OGLEONSKezeH8rosMDAHK0pepLkgHMTdYNHDdgKkIZ6gp0v
        6FBrCT7lDQzSFAOnVuIJh84=
X-Google-Smtp-Source: APXvYqxDsuIHmJIhwyamewaH/a7m0g1m8Ql6oJRGy8hWgRKodPlhvFNhT3klu7XG9iBpAh9VFAPGFg==
X-Received: by 2002:a63:d909:: with SMTP id r9mr7522331pgg.381.1569399522114;
        Wed, 25 Sep 2019 01:18:42 -0700 (PDT)
Received: from SARKAR ([1.186.12.91])
        by smtp.gmail.com with ESMTPSA id q132sm4877466pfq.16.2019.09.25.01.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 01:18:41 -0700 (PDT)
Date:   Wed, 25 Sep 2019 13:48:37 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-newbie@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org
Subject: Hardware prerequisites for driver development
Message-ID: <20190925081836.GA22717@SARKAR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,
This is probably a real rookie question.
I have been interested in contributing to the driver subsystems such as
iio. I have submitted some minor patches but nothing substantial.
I feel that I need some hardware to be able to contribute more.
What hardware would I need to get started?
Where would I get this from?

Thanks,
Rohit
