Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBBDF138F7C
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 11:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgAMKpc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 05:45:32 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45794 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgAMKpb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 05:45:31 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DAhfJj152866;
        Mon, 13 Jan 2020 10:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2019-08-05; bh=LOVU9TaohQ02+RtReLsSqaPxskZ4DAl8707sW3KaYgE=;
 b=XNJWq1JtV89aAIXoBdnUDY8X7NgYM5ULxE+r5qGQLZQDnlhMkVvyPuW45zbHRCQjTFl+
 zHSM3Pcsk+UDdUzoY5YD/zfDdP4fGQ0oQTIhv5Y+BUSjJ4l8qYORz/U3z9axBdxu0DbP
 EtcvERNmY3kh3F44ZfmuX4LMyYlkx9Dda3VETLY12x5iltGhPKeWTKaCYPe1zZoeuhEt
 zYxs6Cqp+z56K2kXQVQ4pdcZxHu+NPr/tDRpj2kz3mXwl9lAEuXh/OfXmzicybvdikZU
 ErnmUh/DV1rXqsCj6RRQ2o6ui5HKSO0LjS3HbLFt+vfdjaWJneyBl2ei8wlG+/6/kqv8 rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xf73te5w7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 10:45:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DAiBAr169126;
        Mon, 13 Jan 2020 10:45:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2xfqu4b6q7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 10:45:23 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00DAjKi3026932;
        Mon, 13 Jan 2020 10:45:20 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 02:45:19 -0800
Date:   Mon, 13 Jan 2020 13:45:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Sandeep Singh <Sandeep.Singh@amd.com>
Cc:     kbuild-all@lists.01.org, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        jic23@kernel.org, linux-iio@vger.kernel.org,
        Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Subject: Re: [PATCH 3/4] SFH: Transport Driver to add support of AMD sensor
 fusion Hub (SFH)
Message-ID: <20200113104510.GD9488@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578558528-10108-1-git-send-email-Sandeep.Singh@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9498 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001130091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9498 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001130091
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Sandeep,

url:    https://github.com/0day-ci/linux/commits/Sandeep-Singh/SFH-Add-Support-for-AMD-Sensor-Fusion-Hub/20200110-084435
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git b07f636fca1c8fbba124b0082487c0b3890a0e0c

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/hid/amd-sfh-hid/amdsfh-hid-client.c:157 amd_sfh_hid_client_probe() warn: possible memory leak of 'cl_dev'
drivers/hid/amd-sfh-hid/amdsfh-hid-client.c:225 amd_sfh_hid_client_remove() warn: variable dereferenced before check 'cl_dev' (see line 218)
drivers/hid/amd-sfh-hid/amdsfh-hid-client.c:225 amd_sfh_hid_client_remove() warn: variable dereferenced before check 'cl_data' (see line 220)
drivers/hid/amd-sfh-hid/amdsfh-debugfs.c:42 amdsfh_debugfs_accel_read() warn: possible memory leak of 'obuf'
drivers/hid/amd-sfh-hid/amdsfh-debugfs.c:78 amdsfh_debugfs_gyro_read() warn: possible memory leak of 'obuf'
drivers/hid/amd-sfh-hid/amdsfh-debugfs.c:114 amdsfh_debugfs_mag_read() warn: possible memory leak of 'obuf'
drivers/hid/amd-sfh-hid/amdsfh-debugfs.c:150 amdsfh_debugfs_als_read() warn: possible memory leak of 'obuf'

# https://github.com/0day-ci/linux/commit/da2b6403065dd09f90ffdd06c25cbc139acde2b8
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout da2b6403065dd09f90ffdd06c25cbc139acde2b8
vim +/cl_dev +157 drivers/hid/amd-sfh-hid/amdsfh-hid-client.c

da2b6403065dd0 Sandeep Singh 2020-01-09  140  static int amd_sfh_hid_client_probe(struct platform_device *pdev)
da2b6403065dd0 Sandeep Singh 2020-01-09  141  {
da2b6403065dd0 Sandeep Singh 2020-01-09  142  	struct amd_mp2_sensor_info info;
da2b6403065dd0 Sandeep Singh 2020-01-09  143  	int rc = 0;
da2b6403065dd0 Sandeep Singh 2020-01-09  144  	int i;
da2b6403065dd0 Sandeep Singh 2020-01-09  145  	struct amdtp_cl_device *cl_dev;
da2b6403065dd0 Sandeep Singh 2020-01-09  146  	struct amdtp_cl_data *cl_data;
da2b6403065dd0 Sandeep Singh 2020-01-09  147  	u32 feature_report_size = 0;
da2b6403065dd0 Sandeep Singh 2020-01-09  148  	u32 input_report_size = 0;
da2b6403065dd0 Sandeep Singh 2020-01-09  149  
da2b6403065dd0 Sandeep Singh 2020-01-09  150  	cl_dev = kzalloc(sizeof(*cl_dev), GFP_KERNEL);
da2b6403065dd0 Sandeep Singh 2020-01-09  151  	if (!cl_dev)
da2b6403065dd0 Sandeep Singh 2020-01-09  152  		return -ENOMEM;
da2b6403065dd0 Sandeep Singh 2020-01-09  153  
da2b6403065dd0 Sandeep Singh 2020-01-09  154  	cl_dev->pdev = pci_get_device(PCI_VENDOR_ID_AMD,
da2b6403065dd0 Sandeep Singh 2020-01-09  155  				      PCI_DEVICE_ID_AMD_MP2, NULL);
da2b6403065dd0 Sandeep Singh 2020-01-09  156  	if (!cl_dev->pdev)
da2b6403065dd0 Sandeep Singh 2020-01-09 @157  		return -ENOMEM;
                                                        ^^^^^^^^^^^^^^
You might want to consider using devm_kzalloc().

da2b6403065dd0 Sandeep Singh 2020-01-09  158  
da2b6403065dd0 Sandeep Singh 2020-01-09  159  	cl_data = kzalloc(sizeof(*cl_data), GFP_KERNEL);
da2b6403065dd0 Sandeep Singh 2020-01-09  160  	cl_data->num_hid_devices = amd_mp2_get_sensor_num
da2b6403065dd0 Sandeep Singh 2020-01-09  161  				   (cl_dev->pdev, &cl_data->sensor_idx[0]);
da2b6403065dd0 Sandeep Singh 2020-01-09  162  
da2b6403065dd0 Sandeep Singh 2020-01-09  163  	INIT_DELAYED_WORK(&cl_data->work, amd_sfh_work);
da2b6403065dd0 Sandeep Singh 2020-01-09  164  	INIT_DELAYED_WORK(&cl_data->work_buffer, amd_sfh_work_buffer);
da2b6403065dd0 Sandeep Singh 2020-01-09  165  	INIT_LIST_HEAD(&req_list.list);
da2b6403065dd0 Sandeep Singh 2020-01-09  166  
da2b6403065dd0 Sandeep Singh 2020-01-09  167  	amdsfh_debugfs_setup(cl_data);
da2b6403065dd0 Sandeep Singh 2020-01-09  168  
da2b6403065dd0 Sandeep Singh 2020-01-09  169  	for (i = 0; i < cl_data->num_hid_devices; i++) {
da2b6403065dd0 Sandeep Singh 2020-01-09  170  		cl_data->sensor_virt_addr[i] = dma_alloc_coherent
da2b6403065dd0 Sandeep Singh 2020-01-09  171  			(&pdev->dev, sizeof(int) * 8,
da2b6403065dd0 Sandeep Singh 2020-01-09  172  			&cl_data->sensor_phy_addr[i], GFP_KERNEL);
da2b6403065dd0 Sandeep Singh 2020-01-09  173  		cl_data->sensor_sts[i] = 0;
da2b6403065dd0 Sandeep Singh 2020-01-09  174  		cl_data->sensor_requested_cnt[i] = 0;
da2b6403065dd0 Sandeep Singh 2020-01-09  175  		cl_data->cur_hid_dev = i;
da2b6403065dd0 Sandeep Singh 2020-01-09  176  
da2b6403065dd0 Sandeep Singh 2020-01-09  177  		cl_data->report_descr_size[i] = get_descriptor_size
da2b6403065dd0 Sandeep Singh 2020-01-09  178  				(cl_data->sensor_idx[i], descr_size);
da2b6403065dd0 Sandeep Singh 2020-01-09  179  
da2b6403065dd0 Sandeep Singh 2020-01-09  180  		feature_report_size = get_descriptor_size
da2b6403065dd0 Sandeep Singh 2020-01-09  181  				(cl_data->sensor_idx[i], feature_size);
da2b6403065dd0 Sandeep Singh 2020-01-09  182  
da2b6403065dd0 Sandeep Singh 2020-01-09  183  		input_report_size =  get_descriptor_size
da2b6403065dd0 Sandeep Singh 2020-01-09  184  			(cl_data->sensor_idx[i], input_size);
da2b6403065dd0 Sandeep Singh 2020-01-09  185  
da2b6403065dd0 Sandeep Singh 2020-01-09  186  		cl_data->feature_report[i] = kzalloc(feature_report_size,
da2b6403065dd0 Sandeep Singh 2020-01-09  187  						     GFP_KERNEL);
da2b6403065dd0 Sandeep Singh 2020-01-09  188  		cl_data->input_report[i] = kzalloc(input_report_size,
da2b6403065dd0 Sandeep Singh 2020-01-09  189  						   GFP_KERNEL);
da2b6403065dd0 Sandeep Singh 2020-01-09  190  		info.period = PERIOD;
da2b6403065dd0 Sandeep Singh 2020-01-09  191  		info.sensor_idx = cl_data->sensor_idx[i];
da2b6403065dd0 Sandeep Singh 2020-01-09  192  		info.phy_address = cl_data->sensor_phy_addr[i];
da2b6403065dd0 Sandeep Singh 2020-01-09  193  		cl_data->report_descr[i] = kzalloc
da2b6403065dd0 Sandeep Singh 2020-01-09  194  			(cl_data->report_descr_size[i], GFP_KERNEL);
da2b6403065dd0 Sandeep Singh 2020-01-09  195  		if (!cl_data->report_descr[i])
da2b6403065dd0 Sandeep Singh 2020-01-09  196  			return -ENOMEM;
da2b6403065dd0 Sandeep Singh 2020-01-09  197  		rc = get_report_descriptor(cl_data->sensor_idx[i],
da2b6403065dd0 Sandeep Singh 2020-01-09  198  					   cl_data->report_descr[i]);
da2b6403065dd0 Sandeep Singh 2020-01-09  199  		rc = amdtp_hid_probe(cl_data->cur_hid_dev, cl_data);
da2b6403065dd0 Sandeep Singh 2020-01-09  200  		rc = amd_start_sensor(cl_dev->pdev, info);
da2b6403065dd0 Sandeep Singh 2020-01-09  201  			cl_data->sensor_sts[i] = 1;
da2b6403065dd0 Sandeep Singh 2020-01-09  202  	}
da2b6403065dd0 Sandeep Singh 2020-01-09  203  
da2b6403065dd0 Sandeep Singh 2020-01-09  204  	cl_dev->cl_data = cl_data;
da2b6403065dd0 Sandeep Singh 2020-01-09  205  	cl_data_context = cl_data;
da2b6403065dd0 Sandeep Singh 2020-01-09  206  	platform_set_drvdata(pdev, cl_dev);
da2b6403065dd0 Sandeep Singh 2020-01-09  207  	schedule_delayed_work(&cl_data->work_buffer, PERIOD);
da2b6403065dd0 Sandeep Singh 2020-01-09  208  	return 0;
da2b6403065dd0 Sandeep Singh 2020-01-09  209  }
da2b6403065dd0 Sandeep Singh 2020-01-09  210  
da2b6403065dd0 Sandeep Singh 2020-01-09  211  static int amd_sfh_hid_client_remove(struct platform_device *pdev)
da2b6403065dd0 Sandeep Singh 2020-01-09  212  {
da2b6403065dd0 Sandeep Singh 2020-01-09  213  	int i;
da2b6403065dd0 Sandeep Singh 2020-01-09  214  	struct amdtp_cl_device *cl_dev;
da2b6403065dd0 Sandeep Singh 2020-01-09  215  	struct amdtp_cl_data *cl_data;
da2b6403065dd0 Sandeep Singh 2020-01-09  216  
da2b6403065dd0 Sandeep Singh 2020-01-09  217  	cl_dev = platform_get_drvdata(pdev);
da2b6403065dd0 Sandeep Singh 2020-01-09 @218  	cl_data = cl_dev->cl_data;
da2b6403065dd0 Sandeep Singh 2020-01-09  219  
da2b6403065dd0 Sandeep Singh 2020-01-09 @220  	for (i = 0; i < cl_data->num_hid_devices; i++)
da2b6403065dd0 Sandeep Singh 2020-01-09  221  		amd_stop_sensor(cl_dev->pdev, i);
da2b6403065dd0 Sandeep Singh 2020-01-09  222  	cancel_delayed_work_sync(&cl_data->work);
da2b6403065dd0 Sandeep Singh 2020-01-09  223  	cancel_delayed_work_sync(&cl_data->work_buffer);
da2b6403065dd0 Sandeep Singh 2020-01-09  224  	amdsfh_debugfs_destroy(cl_data);
da2b6403065dd0 Sandeep Singh 2020-01-09 @225  	if (cl_dev && cl_data)
                                                    ^^^^^^    ^^^^^^^
If these are NULL, it's too late.

da2b6403065dd0 Sandeep Singh 2020-01-09  226  		amdtp_hid_remove(cl_data);
da2b6403065dd0 Sandeep Singh 2020-01-09  227  
da2b6403065dd0 Sandeep Singh 2020-01-09  228  	for (i = 0; i < cl_data->num_hid_devices; i++) {
da2b6403065dd0 Sandeep Singh 2020-01-09  229  		if (cl_data->sensor_virt_addr[i])
da2b6403065dd0 Sandeep Singh 2020-01-09  230  			dma_free_coherent(&pdev->dev, 8 * sizeof(int),
da2b6403065dd0 Sandeep Singh 2020-01-09  231  					  cl_data->sensor_virt_addr[i],
da2b6403065dd0 Sandeep Singh 2020-01-09  232  					  cl_data->sensor_phy_addr[i]);
da2b6403065dd0 Sandeep Singh 2020-01-09  233  	}
da2b6403065dd0 Sandeep Singh 2020-01-09  234  
da2b6403065dd0 Sandeep Singh 2020-01-09  235  	kfree(cl_data);
da2b6403065dd0 Sandeep Singh 2020-01-09  236  	pr_info("%s:%s Exit\n", DRIVER_NAME, __func__);
da2b6403065dd0 Sandeep Singh 2020-01-09  237  	return 0;
da2b6403065dd0 Sandeep Singh 2020-01-09  238  }

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
